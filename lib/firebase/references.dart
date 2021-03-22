import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static final users = FirebaseFirestore.instance.collection("users");
}
