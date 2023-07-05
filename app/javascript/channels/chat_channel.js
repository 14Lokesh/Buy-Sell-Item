import consumer from '../channels/consumer'
document.addEventListener('turbolinks:load', () => {
  const conversationId = document.getElementById('conversation').dataset.conversationId;
  const messageInput = document.getElementById('message_body');
  const messagesContainer = document.getElementById('messages');
  const messageForm=document.getElementById('form')
  if (messageForm) {
    console.log('form')
    messageForm.addEventListener('submit', (event) => {
      event.preventDefault(); // Prevent the default form submission
      
      const formData = new FormData(messageForm);
      
      fetch(messageForm.action, {
        method: messageForm.method,
        body: formData
      })
      .then(response => {
        if (response.ok) {
        } else {
        }
      })
      .catch(error => {
        // Handle any network or JavaScript error
      });
    });
  }

  consumer.subscriptions.create(
      { channel: 'ChatChannel', conversation_id: conversationId },
      {
        connected(){
          console.log("Connected to server")
        },
        received: function (data) {
          console.log(data)
          messagesContainer.insertAdjacentHTML('beforeend', `<p><strong>${data.sender}</strong>: ${data.message}</p>`);
          const messageInput = document.querySelector("#chat_message")
          messageInput.value = ""
          
          const submitButton = document.querySelector("#message_submit")
          submitButton.disabled = false

        },
        speak: function (message) {
          return this.perform('receive', { conversation_id: conversationId, message: message });
        }
      }
    );
});
