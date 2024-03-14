import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/features/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  } static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }
  static Future<void> addUser(UserModel userModel) {
    var collection =getUserCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    return getTaskCollection()
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) {
    return getTaskCollection().doc(model.id).update(model.toJson());
  }
  static void register(String email, String password,String userName) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(id: credential.user?.uid??'', email: email, userName: userName);
      addUser(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }
  static void login(String email, String password) async{

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }
}
