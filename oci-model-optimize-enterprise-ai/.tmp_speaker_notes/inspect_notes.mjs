import { FileBlob, PresentationFile } from "@oai/artifact-tool";

const source = "/Users/dlocklea/Downloads/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck.pptx";
const deck = await PresentationFile.importPptx(await FileBlob.load(source));
const snapshot = await deck.inspect({
  kind: "slide,notes,textbox,shape",
  maxChars: 50000,
});
console.log(snapshot.ndjson);
