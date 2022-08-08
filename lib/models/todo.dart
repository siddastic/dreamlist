class Todo{
  final String id;
  final String title;
  final String place;
  final DateTime endDate;
  final String? notification;
  final bool isDone;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.place,
    required this.endDate,
    required this.createdAt,
    this.notification,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      place: json['place'] as String,
      endDate: DateTime.fromMillisecondsSinceEpoch(json['endDate'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      notification: json['notification'] as String?,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'place': place,
    'endDate': endDate.millisecondsSinceEpoch,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'notification': notification,
    'isDone': isDone,
  };
}