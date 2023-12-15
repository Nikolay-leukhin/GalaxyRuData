class NotificationModel {
  int id;
  String message;
  bool isRead;
  int userId;
  String createdAt;
  String updatedAt;

  NotificationModel({required this.id,
    required this.message,
    required this.isRead,
    required this.userId,
    required this.createdAt,
    required  this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    message = json['message'],
    isRead = json['isRead'],
    userId = json['userId'],
    createdAt = json['createdAt'],
    updatedAt = json['updatedAt'];


  @override
  String toString() => 'Notification id: $id\n message: $message \nisRead: $isRead';
}