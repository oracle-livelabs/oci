import fs from "node:fs/promises";
import JSZip from "jszip";

const source = "/Users/dlocklea/Downloads/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck.pptx";
const output = "/Users/dlocklea/Documents/GitHub/oci/oci-model-optimize-enterprise-ai/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck_with_Speaker_Notes.pptx";
const dataSource = "/Users/dlocklea/Documents/GitHub/oci/oci-model-optimize-enterprise-ai/.tmp_speaker_notes/add_dialogue.mjs";

function extractArray(sourceText, name) {
  const token = `const ${name} = `;
  const start = sourceText.indexOf(token);
  if (start < 0) throw new Error(`Could not find ${name}.`);
  const bracketStart = sourceText.indexOf("[", start);
  let depth = 0;
  let quote = "";
  let escaped = false;
  for (let i = bracketStart; i < sourceText.length; i += 1) {
    const char = sourceText[i];
    if (quote) {
      if (escaped) escaped = false;
      else if (char === "\\") escaped = true;
      else if (char === quote) quote = "";
      continue;
    }
    if (char === "'" || char === '"' || char === "`") quote = char;
    else if (char === "[") depth += 1;
    else if (char === "]") {
      depth -= 1;
      if (depth === 0) return Function(`return ${sourceText.slice(bracketStart, i + 1)}`)();
    }
  }
  throw new Error(`Could not parse ${name}.`);
}

function escapeXml(value) {
  return value.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&apos;");
}

function notesText(dialogue, coaching) {
  const lines = ["Speaker dialogue:", dialogue];
  if (coaching) {
    lines.push("", "Coaching beats (existing):", coaching, "Source anchors: User-provided current messaging notes.");
  }
  return lines.join("\n");
}

function textBody(text) {
  const paragraphs = text.split("\n").map((line) => `<a:p><a:r><a:rPr lang="en-US" dirty="0"/><a:t>${escapeXml(line)}</a:t></a:r></a:p>`).join("");
  return `<p:txBody><a:bodyPr/><a:lstStyle/>${paragraphs}</p:txBody>`;
}

const scriptText = await fs.readFile(dataSource, "utf8");
const dialogue = extractArray(scriptText, "dialogue");
const coaching = extractArray(scriptText, "coaching");
const zip = await JSZip.loadAsync(await fs.readFile(source));

async function notesPartForSlide(slideNumber) {
  const relsName = `ppt/slides/_rels/slide${slideNumber}.xml.rels`;
  const rels = await zip.file(relsName).async("string");
  const match = rels.match(/<Relationship[^>]+Type="[^"]*\/notesSlide"[^>]+Target="\.\.\/notesSlides\/([^\"]+)"[^>]*\/>/);
  return match ? `ppt/notesSlides/${match[1]}` : null;
}

async function addNotesPartForSlide(slideNumber, notesNumber) {
  const sourceNotes = await zip.file("ppt/notesSlides/notesSlide1.xml").async("string");
  const sourceRels = await zip.file("ppt/notesSlides/_rels/notesSlide1.xml.rels").async("string");
  const partName = `ppt/notesSlides/notesSlide${notesNumber}.xml`;
  zip.file(partName, sourceNotes);
  zip.file(`ppt/notesSlides/_rels/notesSlide${notesNumber}.xml.rels`, sourceRels.replace("../../slides/slide2.xml", `../../slides/slide${slideNumber}.xml`));

  const slideRelsName = `ppt/slides/_rels/slide${slideNumber}.xml.rels`;
  const slideRels = await zip.file(slideRelsName).async("string");
  const relationIds = [...slideRels.matchAll(/Id="rId(\d+)"/g)].map((match) => Number(match[1]));
  const nextRelationId = Math.max(...relationIds, 0) + 1;
  const noteRelation = `<Relationship Id="rId${nextRelationId}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesSlide" Target="../notesSlides/notesSlide${notesNumber}.xml"/>`;
  zip.file(slideRelsName, slideRels.replace("</Relationships>", `${noteRelation}</Relationships>`));

  const contentTypes = await zip.file("[Content_Types].xml").async("string");
  const override = `<Override PartName="/ppt/notesSlides/notesSlide${notesNumber}.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml"/>`;
  zip.file("[Content_Types].xml", contentTypes.replace("</Types>", `${override}</Types>`));
  return partName;
}

let nextNotesNumber = 12;
for (let index = 0; index < dialogue.length; index += 1) {
  const slideNumber = index + 1;
  let partName = await notesPartForSlide(slideNumber);
  if (!partName) {
    partName = await addNotesPartForSlide(slideNumber, nextNotesNumber);
    nextNotesNumber += 1;
  }
  const part = zip.file(partName);
  if (!part) throw new Error(`Missing notes part: ${partName}`);
  const xml = await part.async("string");
  const replacement = textBody(notesText(dialogue[index], coaching[index]));
  let replaced = false;
  const updated = xml.replace(/<p:sp>[\s\S]*?<\/p:sp>/g, (shape) => {
    if (replaced || !shape.includes('<p:ph type="body"')) return shape;
    replaced = true;
    return shape.replace(/<p:txBody>[\s\S]*?<\/p:txBody>/, replacement);
  });
  if (!replaced) throw new Error(`No notes body placeholder found in ${partName}`);
  zip.file(partName, updated);
}

await fs.writeFile(output, await zip.generateAsync({ type: "nodebuffer", compression: "DEFLATE" }));
