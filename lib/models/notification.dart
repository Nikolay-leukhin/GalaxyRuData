class NotificationModel {
  int id;
  String message;
  bool isRead;
  int userId;
  String createdAt;
  String updatedAt;
  String? _lastSendToUser;

  NotificationModel({
    required this.id,
    required this.message,
    required this.isRead,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'],
        isRead = json['isRead'],
        userId = json['userId'],
        createdAt = json['createdAt'],
        _lastSendToUser = json['lastSend'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'isRead': isRead,
        'userId': userId,
        'createdAt': createdAt,
        'message': message,
        'updatedAt': updatedAt,
        'lastSend': _lastSendToUser
      };

  @override
  String toString() =>
      '{\n\t\tnotification id: $id\n\t\tmessage: $message \n\t\tisRead: $isRead \n\t\tlastSend: $_lastSendToUser\n}';

  DateTime? get lastSend =>
      _lastSendToUser != null ? DateTime.parse(_lastSendToUser!) : null;

  set newSendTime(DateTime newTime) =>
      _lastSendToUser = newTime.toIso8601String();

  @override
  bool operator ==(Object other) =>
      other is NotificationModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
