import { FileBlob, PresentationFile } from "@oai/artifact-tool";

const source = "/Users/dlocklea/Downloads/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck.pptx";
const output = "/Users/dlocklea/Documents/GitHub/oci/oci-model-optimize-enterprise-ai/One_Oracle_Speakers_Bureau_Bravo_Candidate_Deck_with_Speaker_Notes.pptx";

const dialogue = [
  "Before we begin, a quick reminder: this is an internal enablement conversation. The purpose is to practice how we translate One Oracle into a clear, customer-relevant story. We are not presenting this deck externally; we are building the confidence and language to have a stronger customer conversation.",
  "When I talk with customer leaders, I start with the outcome they are trying to achieve—not with a list of products. The One Oracle advantage is that we can bring the breadth of our portfolio together behind that outcome, helping reduce complexity so their teams can focus on moving the business forward.",
  "Here is the path for our conversation. We will begin with what customers are navigating today, then look at how Oracle can help, and finally connect that to practical next steps. The important point is that we start with the customer’s priorities and let the capabilities support that story.",
  "Across industries, we hear a consistent set of needs. Leaders want AI that improves real work, execution they can trust, and technology that helps teams act together rather than in silos. They also need their environment to remain connected and open. That is the reality we should respond to in the customer’s language.",
  "These challenges are not signs that a customer has done something wrong; they are the natural result of running a complex enterprise. Priorities cross teams, systems, and data. When workflows are disconnected, ownership and speed suffer. And AI only creates value when it is governed and connected to execution. Customers need a partner that can help absorb that complexity.",
  "Oracle’s role is to meet the customer at the outcome they care about, in the context of their industry and operating model. Then we bring the right parts of the portfolio together to help them execute. If I mention a capability, I immediately connect it back to the business result it enables—because the outcome, not the product list, is the point.",
  "This is the heart of the One Oracle story: one customer outcome conversation, supported by a coordinated portfolio. Applications bring business-process context. Data and database provide trusted information. Cloud and AI turn that context into action. And open integration connects that value to the rest of the customer’s environment. The power is in the combination.",
  "Applications are where much of the business work actually happens. They provide the process and workflow context that helps us understand what needs to improve. Our goal is not to make this an applications-only conversation; it is to show how that context can connect to trusted data and practical AI to help people make better decisions and execute with more confidence.",
  "Trusted outcomes start with trusted information. Data and database help give customers the confidence that the signals behind their decisions are reliable and usable. That does not mean every data source has to be Oracle. It means Oracle can help connect information in a way that supports clearer decisions, more effective action, and a stronger foundation for AI.",
  "For customers, AI matters when it improves a real workflow or helps a team execute better at scale. That is the standard we should use: practical, governed, and connected to the work people already do. We should be precise about what is available today and keep people appropriately involved in decisions, oversight, and accountability.",
  "One Oracle does not mean an Oracle-only environment. Customers operate mixed estates, and our value increases when we work with that reality. Open integration helps connect Oracle capabilities with the systems, data, and processes customers already rely on. That is how we earn trust: by helping create value across their environment, not by asking them to ignore it.",
  "The most useful next step is a focused customer conversation. Start with the outcome that matters most, then map the teams, decisions, data, and systems behind it. From there, identify where Oracle can reduce complexity and where AI can make execution more practical. We move forward where the value is clear and the customer has confidence in the path.",
  "As an Oracle customer, you have access to more than individual capabilities—you have the One Oracle advantage. The opportunity is to bring that breadth together around the outcomes that matter most to your organization, in a way that is practical, connected, and grounded in trust.",
  "Thank you. I would pause here and invite the conversation back to the customer: Which outcome is most important right now, and where is complexity getting in the way? That question helps turn the One Oracle story into a useful next discussion rather than a closing statement.",
  "Use this final blank slide only as a clean stopping point if needed. After the discussion, thank the audience and confirm the agreed follow-up or next conversation."
];

const coaching = [
  "",
  "Open directly to a customer executive; state the outcome thesis plainly; use the portfolio as delivery logic rather than the headline; avoid a product inventory.",
  "Set a customer-conversation arc in about 30 seconds; start with customer needs before Oracle capabilities.",
  "Translate Oracle priorities into customer language; present them as needs rather than an internal operating model; aim for about one minute.",
  "Frame the slide as operating reality, not criticism; create the need for One Oracle; keep AI grounded in risk, governance, and execution.",
  "Lead with the customer outcome and industry context; tie every product mention back to the outcome; use 60–90 seconds.",
  "Emphasize the combined portfolio—applications, data, database, cloud, AI, and integration; make One Oracle a customer story, not an internal slogan; avoid feature lists and competitive attacks.",
  "Show why the application core matters; keep Fusion Apps expertise visible without making the story Apps-only; tie application context to practical AI and execution.",
  "Position data and database as the trust foundation for outcomes and AI; speak in customer terms—decisions, confidence, action, and connected value; acknowledge open integration.",
  "Keep AI practical and current; use shipped/current capability language only; connect AI to workflows and execution; use human-in-the-lead/on-the-loop language where useful.",
  "Make clear that One Oracle does not require an Oracle-only environment; ground differentiation in combination and execution; reinforce trust through compatibility with the customer’s real estate.",
  "Close with actionable next steps; reconnect outcomes, portfolio breadth, practical AI, open integration, and trust; invite discussion around priority outcomes.",
  "",
  "",
  ""
];

const deck = await PresentationFile.importPptx(await FileBlob.load(source));
for (let index = 0; index < deck.slides.items.length; index += 1) {
  const slide = deck.slides.items[index];
  const notes = [
    "Speaker dialogue:",
    dialogue[index],
    coaching[index] ? `\nCoaching beats (existing):\n${coaching[index]}\nSource anchors: User-provided current messaging notes.` : "",
  ].filter(Boolean).join("\n");
  slide.speakerNotes.textFrame.setText(notes);
  slide.speakerNotes.setVisible(true);
}

const pptx = await PresentationFile.exportPptx(deck);
await pptx.save(output);
