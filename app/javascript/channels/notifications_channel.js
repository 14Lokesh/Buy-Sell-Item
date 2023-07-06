import consumer from "./consumer"
console.log("checking notification")
consumer.subscriptions.create({channel: "NotificationsChannel"}, {
  connected() {
    console.log('Connected to NotificationsChannel');
  },

  disconnected() {
  },
 
  received(data) {
    console.log('Received data:', data);
    const notificationsContainer = document.querySelector("#notifications-container");
    const notificationItem = document.createElement("div");
    notificationItem.classList.add("notification-item");
    notificationItem.textContent = data.notification['message'];
    notificationsContainer.appendChild(notificationItem);
    var counterElement = document.getElementById('notificationCounter')
    var counter = parseInt(counterElement.textContent)
    counter +=1
    counterElement.textContent = counter;
  }
});
