class TaskModel {
  String? title;
  String? description;
  String? time;

  TaskModel({this.title, this.description, this.time});

// receiving data from server
  factory TaskModel.fromMap(map) {
    return TaskModel(
      title: map['title'],
      description: map['description'],
      time: map['time'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time,
    };
  }
}