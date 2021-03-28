import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static final users = FirebaseFirestore.instance.collection("users");
  static final restaurants =
      FirebaseFirestore.instance.collection("restaurants");
  static final favs = FirebaseFirestore.instance.collection("favoritos");
  static final resenas = FirebaseFirestore.instance.collection("resenas");
}
