import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/post_details.dart';

class PostDetail extends StatelessWidget {
  final List<PostDetails>? postDetails;
  const PostDetail({
    super.key,
    required this.postDetails,
  });

  @override
  Widget build(BuildContext context) {
    final content = postDetails == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: postDetails!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final PostDetails postDetail = postDetails![index];
              final postTitle = postDetail.details;
              final postLimitPiece = postDetail.limitAllPiece;
              final postLimitPerPerson = postDetail.limitPerPerson;
              final postLimitTime = postDetail.limitTime;
              final postImages = postDetail.imageUrlList;
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Profile
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1611604548018-d56bbd85d681?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxsZWdvfGVufDB8fHx8MTcwNzMzMjIyMnww&ixlib=rb-4.0.3&q=80&w=1080',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ลี ยัง จุน',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF172026),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'วันนี้ 10.30น.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF36485C),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                          child: Text(
                            postTitle,
                            style: const TextStyle(
                              fontFamily: 'Mitr',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),

                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color(0xFF6229EE),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                                    child: Text(
                                      '$postLimitPiece จำนวน',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF6229EE),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(1, 0, 6, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color(0xFF6229EE),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                                    child: Text(
                                      'จำกัด $postLimitPerPerson /คน',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF6229EE),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 6, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color(0xFF6229EE),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                                    child: Text(
                                      'เปิดรับถึง $postLimitTime',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color(0xFF6229EE),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                    // child: Swiper(itemCount: postImages.length),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Check แล้ว  คน',
                                style: TextStyle(
                                  fontFamily: 'Mitr',
                                  color: Color(0xFFC7C7CC),
                                  fontWeight: FontWeight.w300,
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
            },
          );

    return content;
  }
}
