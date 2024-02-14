import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_details.dart';

class FirebaseService {
  final db = FirebaseFirestore.instance;

  Future<List<PostDetails>> getPosts() async {
    try {
      final query = await db.collection("posts").orderBy("timestamp").get();
      return query.docs.map((doc) => PostDetails.fromJson(doc.data())).toList();

    } catch (error) {
      rethrow;
    }
  }
}
