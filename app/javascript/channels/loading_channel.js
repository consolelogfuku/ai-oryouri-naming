import consumer from "./consumer"

consumer.subscriptions.create("LoadingChannel", {
  received(data) {
    if (data.event === 'showLoadingModal') {
      const hiddenElements = document.querySelectorAll("[data-behavior='hidden']");
        hiddenElements.forEach( (hiddenElement) => {
          hiddenElement.classList.remove('hidden');
        });
    }
  }
});
