import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDm {
  static String collectionName = "todo";
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  ToDoDm({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  ToDoDm.fromFireStore(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    Timestamp timestamp = json['date'];
    date = timestamp.toDate();
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        'title': title,
        'description': description,
        'date': date,
        "isDone": isDone,
      };

  static CollectionReference getTodoCollection(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(collectionName);
  }

  static Future<void> addTodo(ToDoDm userTodo, String userId) {
    var todoCollection = getTodoCollection(userId);
    var task = todoCollection.doc();
    userTodo.id = task.id;
    return task.set(userTodo.toJson());
  }

  static Future<void> updateTodos(String userId, ToDoDm todo) async {
    var todoCollection = getTodoCollection(userId);
    var doc = todoCollection.doc(todo.id);
    await doc.update(todo.toJson());
  }

  static Future<void> deleteTodos(String userId , String toDoId)async {
  var todoCollection = getTodoCollection(userId);
  var todoDoc = todoCollection.doc(toDoId);
  await todoDoc.delete();
  }
}
