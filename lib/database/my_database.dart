import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/date_utils.dart';

import 'Task.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: ((snapshot, options) {
      return Task.fromFireStore(snapshot.data()!);
    }), toFirestore: (task, options) {
      return task.toFireStore();
    });
  }

  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    var doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<QuerySnapshot<Task>> getAllTasks(DateTime selectedDate) async {
    return await getTasksCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
  }

  static Stream<QuerySnapshot<Task>> listenForTasksRealTimeUpdates(
      DateTime selectedDate) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }

  static editIsDone(task) {
    CollectionReference todoRef = getTasksCollection();
    todoRef.doc(task.id).update({'isDone': task.isDone! ? null : true});
  }

  static editTask(task) {
    CollectionReference todoRef = getTasksCollection();
    todoRef.doc(task.id).update({
      //'title': TaskEdit.titleController,
    });
  }
}
