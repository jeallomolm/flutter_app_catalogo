import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static final users = FirebaseFirestore.instance.collection("users");
  static final restaurants =
      FirebaseFirestore.instance.collection("restaurants");
}
