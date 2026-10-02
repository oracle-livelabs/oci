// The shared renderer currently omits the title when constructing its help link.
// Keep the standard icon and support pages, but use this workshop's metadata.
(() => {
  "use strict";
  document.addEventListener("DOMContentLoaded", async () => {
    try {
      const response = await fetch("manifest.json");
      if (!response.ok) return;
      const manifest = await response.json();
      if (!manifest.help || !manifest.workshoptitle) return;
      const href = "mailto:" + manifest.help + "?subject=" +
        encodeURIComponent("Question about workshop: " + manifest.workshoptitle);
      const updateHelp = () => {
        document.querySelectorAll("a#need_help").forEach(link => {
          if (link.getAttribute("href") !== href) link.setAttribute("href", href);
        });
      };
      updateHelp();
      const header = document.querySelector("header");
      if (header) new MutationObserver(updateHelp).observe(header, {
        childList: true,
        subtree: true
      });
    } catch {
      // A failed metadata request must not prevent the workshop from loading.
    }
  });
})();
