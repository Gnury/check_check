import 'dart:developer';

import 'package:check_check_app/components/firebase_service.dart';
import 'package:check_check_app/components/post.dart';
import 'package:check_check_app/models/post_details.dart';
import 'package:check_check_app/pages/create_post.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FeedPage();
}

class _FeedPage extends State<FeedPage> {
  final FirebaseService _firebaseService = FirebaseService();

  List<PostDetails>? posts;

  @override
  void initState() {
    log('_getPosts');
    super.initState();
    _getPosts();
  }

  Future<void> _getPosts() async {
    log('_getPosts');
    final result = await _firebaseService.getPosts();
    setState(() {
      posts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('on build: $posts');
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFCE5E6),
              Color(0xFFDDEEF8),
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: NetworkImage("https://via.placeholder.com/39x39"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePost(),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFFCE5E6),),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "คุณอยากจะ Check อะไรมั้ย?",
                          style: TextStyle(
                            color: Color(0xFF36485C),
                            fontSize: 14,
                            fontFamily: "Mitr",
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            const Expanded(
              child: Post(),
            ),
          ],
        ),
      ),
    );
  }
}
