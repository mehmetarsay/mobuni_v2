enum NotificationType { standart, chat }

extension IntToNotificationTypeExtension on int {
  NotificationType get intToNotificationType {
    switch (this) {
      case 0:
        return NotificationType.standart;
      case 1:
        return NotificationType.chat;
      default:
        return NotificationType.standart;
    }
  }
}