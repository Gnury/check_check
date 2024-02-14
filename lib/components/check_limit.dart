import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:check_check_app/components/limit_button.dart';
import 'package:check_check_app/components/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'add_image_button.dart';

class CheckLimit extends StatefulWidget {
  final TextEditingController detailsController;
  final TextEditingController allPieceController;
  final TextEditingController huNumController;
  final int? timeSelected;
  final Function(int) onTimeSelected;
  final List<String> imageListOfProduct;
  final Function(bool) onLimitAllPieceChanged;
  final Function(bool) onLimitPerPersonChange;
  final Function(bool) onLimitTimeChange;
  final bool isLimitAllPiece;
  final bool isLimitPerPerson;
  final bool isLimitTime;

  const CheckLimit({
    super.key,
    required this.detailsController,
    required this.imageListOfProduct,
    required this.allPieceController,
    required this.timeSelected,
    required this.onTimeSelected,
    required this.huNumController,
    required this.onLimitAllPieceChanged,
    required this.onLimitPerPersonChange,
    required this.onLimitTimeChange,
    required this.isLimitAllPiece,
    required this.isLimitTime,
    required this.isLimitPerPerson,
  });

  @override
  State<StatefulWidget> createState() => _CheckLimit();
}

class _CheckLimit extends State<CheckLimit> {
  int currentIndex = 0;
  final ImagePicker _picker = ImagePicker();
  SwiperController swiperController = SwiperController();

  final _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        widget.imageListOfProduct.add(image.path);
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickCameraImage() async {
    try {
      final picture = await _picker.pickImage(source: ImageSource.camera);
      if (picture == null) return;

      setState(() {
        widget.imageListOfProduct.add(picture.path);
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future showOptions() async {
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "เพิ่มรูปภาพ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6229EE),
                  fontSize: 20,
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickImage();
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
                              Icon(
                                Icons.photo_library,
                                color: Color(0xFF6229EE),
                              ),
                              Text(
                                'อัปโหลด',
                                style: TextStyle(
                                  color: Color(0xFF6229EE),
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
                          pickCameraImage();
                        },
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
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
                              Icon(
                                Icons.camera_alt,
                                color: Color(0xFF6229EE),
                              ),
                              Text(
                                'ถ่ายภาพ',
                                style: TextStyle(
                                  color: Color(0xFF6229EE),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
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
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          TextInputField(
            detailsController: widget.detailsController,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              LimitButton(
                onPressButton: (isLimitAllPiece) =>
                    widget.onLimitAllPieceChanged(widget.isLimitAllPiece),
                isChecked: widget.isLimitAllPiece,
              ),
              const Text(
                "จำนวนการรับหิ้ว",
                style: TextStyle(
                  color: Color(0xFF172026),
                  fontSize: 14,
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ],
          ),
          !widget.isLimitAllPiece
              ? const SizedBox(
                  height: 12,
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.allPieceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFF2F2F7),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFF6229EE),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          hintText: "รายละเอียด...",
                          hintStyle: const TextStyle(
                            color: Color(0xFFC7C7CC),
                            fontSize: 10,
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
          Row(
            children: [
              LimitButton(
                onPressButton: (isLimitPerPerson) =>
                    widget.onLimitPerPersonChange(widget.isLimitPerPerson),
                isChecked: widget.isLimitPerPerson,
              ),
              const Text(
                "จำกัดจำนวน (ต่อคน)",
                style: TextStyle(
                  color: Color(0xFF172026),
                  fontSize: 14,
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ],
          ),
          !widget.isLimitPerPerson
              ? const SizedBox(
                  height: 12,
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.huNumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFF2F2F7),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFF6229EE),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          hintText: "รายละเอียด...",
                          hintStyle: const TextStyle(
                            color: Color(0xFFC7C7CC),
                            fontSize: 10,
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
          Row(
            children: [
              LimitButton(
                onPressButton: (isLimitTime) =>
                  widget.onLimitTimeChange(widget.isLimitTime),
                isChecked: widget.isLimitTime,
              ),
              const Text(
                "จำกัดเวลา",
                style: TextStyle(
                  color: Color(0xFF172026),
                  fontSize: 14,
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ],
          ),
          !widget.isLimitTime
              ? const SizedBox(
                  height: 12,
                )
              : Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Text.rich(
                            TextSpan(
                              children: [
                                widget.timeSelected != null
                                    ? TextSpan(
                                        text: DateFormat("dd EEEE MMMM y h:m")
                                            .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            widget.timeSelected!,
                                          ),
                                        ),
                                      )
                                    : const WidgetSpan(
                                        child: SizedBox(
                                          width: 12,
                                          height: 12,
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
                    ],
                  ),
                ),
          const SizedBox(
            height: 12,
          ),
          widget.imageListOfProduct.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width - 64,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Swiper(
                    controller: swiperController,
                    itemCount: widget.imageListOfProduct.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final picture = widget.imageListOfProduct[index];
                      return Image.file(
                        File(picture),
                        fit: BoxFit.cover,
                      );
                    },
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    pagination: const SwiperPagination(),
                    onIndexChanged: (index) {
                      currentIndex = index;
                    },
                  ),
                )
              : const SizedBox(
                  width: 12,
                  height: 12,
                ),
          const SizedBox(
            height: 12,
          ),
          AddImageButton(
            isImageContain: widget.imageListOfProduct.isNotEmpty,
            onAddImagePressed: () {
              setState(() {
                showOptions();
              });
            },
            onRemoveImagePressed: () {
              if (widget.imageListOfProduct.isNotEmpty) {
                setState(() {
                  widget.imageListOfProduct.removeAt(currentIndex);
                });
              }
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
