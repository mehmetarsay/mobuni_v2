enum NotificationType {
  standart,
  chat,
  questionLike,
  activityLike,
  questionCommentLike,
  activityCommentLike,
  activityComment,
  questionComment,
  activityJoined
}

extension IntToNotificationTypeExtension on int {
  NotificationType get intToNotificationType {
    switch (this) {
      case 0:
        return NotificationType.standart;
      case 1:
        return NotificationType.chat;
      case 2:
        return NotificationType.questionLike;
      case 3:
        return NotificationType.activityLike;
      case 4:
        return NotificationType.questionCommentLike;
      case 5:
        return NotificationType.activityCommentLike;
      case 6:
        return NotificationType.activityComment;
      case 7:
        return NotificationType.questionComment;
      case 8:
        return NotificationType.activityJoined;
      default:
        return NotificationType.standart;
    }
  }
}
