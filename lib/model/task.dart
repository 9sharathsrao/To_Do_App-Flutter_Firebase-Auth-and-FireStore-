class Task {
  //Variables
  int? id;
  final String title;
  final String date;
  final bool isDone;

  //Constructor
  Task({
    this.id,
    required this.title,
    required this.date,
    this.isDone = false,
  });

  //Define two methods
  //Take data from us through and passes it to the database. Format is Map
  //Converting application format into database format
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'date': date,
    'isDone': isDone, // 0 for false, 1 for true
  };
}

  //Convert database format to application format
  factory Task.fromMap(Map<String,dynamic> map){
    return Task(
      date:map['date'],
      title: map['title'],
      id: map['id'],
      isDone: map['isDone'] == 1
    );
  }
}