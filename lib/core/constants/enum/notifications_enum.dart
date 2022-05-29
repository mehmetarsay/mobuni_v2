enum NotificationType { standart, chat, question, activity}

extension IntToNotificationTypeExtension on int {
  NotificationType get intToNotificationType {
    switch (this) {
      case 0:
        return NotificationType.standart;
      case 1:
        return NotificationType.chat;
      case 2:
        return NotificationType.question;
      case 3:
        return NotificationType.activity;
      default:
        return NotificationType.standart;
    }
  }
}