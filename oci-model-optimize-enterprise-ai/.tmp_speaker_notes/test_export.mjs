import { FileBlob, PresentationFile } from "@oai/artifact-tool";

const source = "/Users/dlocklea/Downloads/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck.pptx";
const output = "/Users/dlocklea/Documents/GitHub/oci/oci-model-optimize-enterprise-ai/.tmp_speaker_notes/test-export.pptx";
const deck = await PresentationFile.importPptx(await FileBlob.load(source));
const pptx = await PresentationFile.exportPptx(deck);
await pptx.save(output);
