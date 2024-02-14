import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:check_check_app/components/check_limit.dart';
import 'package:check_check_app/components/check_options.dart';
import 'package:check_check_app/pages/feed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePost();
}

class _CreatePost extends State<CreatePost> {
  final detailsController = TextEditingController();
  final optionsInputController = TextEditingController();
  final allPieceController = TextEditingController();
  final huNumController = TextEditingController();
  final timeSelected = int;

  late final List<String> imageListOfProduct = [];
  List<String> options = [];

  bool isLimitAllPiece = false;
  bool isLimitPerPerson = false;
  bool isLimitTime = false;
  int? limitTime;
  bool isPress = true;
  bool isTap = true;

  void clearText() {
    optionsInputController.clear();
  }

  void selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        final now = DateTime.now();
        final limit = DateTime(
          now.year,
          now.month,
          now.day,
          newTime.hour,
          newTime.minute,
        );
        // widget.onTimeSelected(limit.millisecondsSinceEpoch);
      });
    }
  }

  Future<void> uploadToDatabase() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("images");
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    List<String> downloadUrls = [];
    try {
      for (int i = 0; i < imageListOfProduct.length; i++) {
        await referenceImageToUpload.putFile(File(imageListOfProduct[i]));
        final downloadUrl = await referenceImageToUpload.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    } catch (error) {
      return;
    }

    if (detailsController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("posts").doc().set({
        "Details": detailsController.text,
        "LimitPiece": allPieceController.text,
        "LimitPerson": huNumController.text,
        "LimitTime": timeSelected.toString(),
        "ImagesList": downloadUrls,
        "Options": options,
        "Timestamp": Timestamp.now().millisecondsSinceEpoch,
      });

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const FeedPage(),
          ),
        );
      }
    }
  }

  Widget adaptiveAction(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  Future showInputOptionsDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Column(
            children: [
              const Text(
                "กรอกตัวเลือก",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6229EE),
                  fontSize: 20,
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: optionsInputController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFF2F2F7),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF6229EE),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "เพิ่มตัวเลือก",
                        hintStyle: const TextStyle(
                          color: Color(0xFFC7C7CC),
                          fontSize: 14,
                          fontFamily: 'Mitr',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF6229EE),
                      ),
                    ),
                    child: const Text("ยกเลิก"),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      options.add(optionsInputController.text);
                      Navigator.pop(context);
                      clearText();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF6229EE),
                      ),
                    ),
                    child: const Text("ยืนยัน"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                      width: 45,
                      height: 45,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, color: Color(0xFFFCE5E6)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Container(
                        width: 38.86,
                        height: 38.86,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/39x39"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    children: [
                      Text("Name Surname"),
                      Text(
                        "Description",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              CheckLimit(
                onLimitAllPieceChanged: (isLimitAllPiece) {
                  setState(() {
                    this.isLimitAllPiece = !isLimitAllPiece;
                  });
                },
                imageListOfProduct: imageListOfProduct,
                allPieceController: allPieceController,
                huNumController: huNumController,
                onLimitPerPersonChange: (isLimitPerPerson) {
                  setState(() {
                    this.isLimitPerPerson = !isLimitPerPerson;
                  });
                },
                onLimitTimeChange: (isLimitTime) {
                  setState(() {
                    this.isLimitTime = !isLimitTime;
                  });
                  (!isLimitTime) ? selectTime() : null;
                },
                isLimitAllPiece: isLimitAllPiece,
                isLimitTime: isLimitTime,
                isLimitPerPerson: isLimitPerPerson,
                detailsController: detailsController,
                timeSelected: limitTime,
                onTimeSelected: (int o) {
                  setState(() {
                    limitTime = o;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "เพิ่มตัวเลือก",
                    style: TextStyle(
                      color: Color(0xFF6229EE),
                      fontSize: 16,
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final option = options[index];
                  log(option);
                  return Row(
                    children: [
                      CheckOptions(
                        onAddOption: () {
                          setState(() {
                            options.removeAt(index);
                          });
                        },
                        isTap: isTap,
                      ),
                      Text(
                        option,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Mitr',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  );
                },
              ),
              //options.isNotEmpty ? options : SizedBox(),
              Row(
                children: [
                  CheckOptions(
                    onAddOption: () {
                      setState(() {
                        showInputOptionsDialog();
                      });
                    },
                    isTap: !isTap,
                  ),
                  const Text(
                    "เพิ่มตัวเลือก",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              //Button
              Row(
                children: [
                  const Align(
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Container(
                              height: 245,
                              padding: const EdgeInsets.all(24),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "ยกเลิกโพสต์",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF6229EE),
                                      fontSize: 20,
                                      fontFamily: 'Mitr',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'คุณกำลังยกเลิกโพสต์\nต้องการดำเนินการต่อหรือไม่?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF36485C),
                                      fontSize: 16,
                                      fontFamily: 'Mitr',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context, "No");
                                          },
                                          child: Container(
                                            height: 44,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF00BF63),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                    color: Color(0xFF00BF63),
                                                    fontSize: 16,
                                                    fontFamily: 'Mitr',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FeedPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 44,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                            decoration: ShapeDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment(0.74, -0.67),
                                                end: Alignment(-0.74, 0.67),
                                                colors: [
                                                  Color(0xFFFF3131),
                                                  Color(0xFFFF5757)
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'ยืนยัน',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Mitr',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF6229EE),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color(0xFF6229EE),
                                fontSize: 20,
                                fontFamily: 'Mitr',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        uploadToDatabase();
                      },
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF6229EE), Color(0xFF9267FE)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "LET’S CHECK",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Mitr",
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
