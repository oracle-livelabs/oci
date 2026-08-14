import { FileBlob, PresentationFile } from "@oai/artifact-tool";

const source = "/Users/dlocklea/Documents/GitHub/oci/oci-model-optimize-enterprise-ai/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck_with_Speaker_Notes.pptx";
const deck = await PresentationFile.importPptx(await FileBlob.load(source));
const snapshot = await deck.inspect({ kind: "slide,notes", maxChars: 50000 });
console.log(snapshot.ndjson);
