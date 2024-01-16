import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Stream<List<UserModel>> _readData(){
  final userCollection = FirebaseFirestore.instance.collection("users");

  return userCollection.snapshots().map((qureySnapshot)
  => qureySnapshot.docs.map((e)
  => UserModel.fromSnapshot(e),).toList());
}

void _createData(UserModel userModel) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  String id = userCollection.doc().id;

  final newUser = UserModel(
    username: userModel.username,
    age: userModel.age,
    adress: userModel.adress,
    id: id,
  ).toJson();

  userCollection.doc(id).set(newUser);
}

void _updateData(UserModel userModel) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  final newData = UserModel(
    username: userModel.username,
    id: userModel.id,
    adress: userModel.adress,
    age: userModel.age,
  ).toJson();

  userCollection.doc(userModel.id).update(newData);

}

void _deleteData(String id) {
  final userCollection = FirebaseFirestore.instance.collection("users");

  userCollection.doc(id).delete();

}


class UserModel{
  final String? username;
  final String? adress;
  final int? age;
  final String? id;

  UserModel({this.id,this.username, this.adress, this.age});


  static UserModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
