import consumer from "./consumer"
console.log("checking notification")
consumer.subscriptions.create({channel: "NotificationsChannel"}, {
  connected() {
    console.log(' Connected to NotificationsChannel');
  },

  disconnected() {
  },
 
  received(data) {
    console.log('Received data:', data);
    // var li = document.createElement('li');
    // li.className = 'dropdown-item';
    // li.textContent = data.notification['message'];
    // document.getElementById('notification').appendChild(li); 
    const notificationsContainer = document.querySelector("#notifications-container");
    const notificationItem = document.createElement("div");
    notificationItem.classList.add("notification-item");
    notificationItem.textContent = data.notification['message'];
    notificationsContainer.appendChild(notificationItem);

  }
});
