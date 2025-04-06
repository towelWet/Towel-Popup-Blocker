chrome.webRequest.onBeforeRequest.addListener(
  function(details) {
    if (details.type === 'popup') {
      return {cancel: true};
    }
  },
  {urls: ["<all_urls>"]},
  ["blocking"]
);
