import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileModifyPage extends ConsumerStatefulWidget {
  const ProfileModifyPage({super.key});

  @override
  ConsumerState<ProfileModifyPage> createState() => _ProfileModifyPageState();
}

class _ProfileModifyPageState extends ConsumerState<ProfileModifyPage> {
  late final String? existingProfileImageUrl;
  late final String? existingBackgroundImageUrl;

  File? _selectedProfileImage;
  File? _selectedBackgroundImage;

  Future loadImages() async {
    return true;
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedProfileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickBackgroundImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedBackgroundImage = File(pickedFile.path);
      });
    }
  }

  void _upload() {
    if (_selectedProfileImage != null && _selectedBackgroundImage != null) {
      // 여기서 서버 업로드 로직 실행
    }
  }

  @override
  void initState() {
    existingProfileImageUrl = 'assets/png/notice.png'; // 기존 프로필 이미지 url 가지고 오기
    existingBackgroundImageUrl = ''; // 기존 배경 이미지 url 가지고 오기

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.height * (402 / 874);
    final double heightRatio = size.height / 874;

    Widget displayedImage;
    if (_selectedProfileImage != null) {
      displayedImage = Image.file(
        _selectedProfileImage!,
        width: 87,
        height: 87,
      );
    } else {
      displayedImage = Image.network(
        existingProfileImageUrl!,
        width: 87,
        height: 87,
      );
    }

    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: loadImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 92 * heightRatio,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    43 * heightRatio,
                    15 * heightRatio,
                    10 * heightRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 70 * heightRatio,
                        width: 70 * heightRatio,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).pop(); //go('/profile');
                              },
                              child: Container(
                                height: 35 * heightRatio,
                                width: 35 * heightRatio,
                                child: SvgPicture.asset(
                                  'svg/chevron-left.svg',
                                  height: 33 * heightRatio,
                                  width: 33 * heightRatio,
                                  colorFilter: ColorFilter.mode(
                                    Color(0xFF000000),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          '프로필 수정',
                          style: TextStyle(
                            fontSize: 20 * heightRatio,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 70 * heightRatio,
                        width: 70 * heightRatio,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 87 * heightRatio,
                  width: 87 * heightRatio,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9),
                  ),
                  alignment: Alignment.centerLeft,
                  child: displayedImage,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 34 * heightRatio,
                        width: 142 * heightRatio,
                        margin: EdgeInsets.fromLTRB(
                          3 * heightRatio,
                          8 * heightRatio,
                          3 * heightRatio,
                          8 * heightRatio,
                        ),
                        padding: EdgeInsets.fromLTRB(
                          5 * heightRatio,
                          5 * heightRatio,
                          5 * heightRatio,
                          5 * heightRatio,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '프로필 사진 수정',
                          style: TextStyle(
                            fontSize: 13 * heightRatio,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 34 * heightRatio,
                        width: 142 * heightRatio,
                        margin: EdgeInsets.fromLTRB(
                          3 * heightRatio,
                          8 * heightRatio,
                          3 * heightRatio,
                          8 * heightRatio,
                        ),
                        padding: EdgeInsets.fromLTRB(
                          5 * heightRatio,
                          5 * heightRatio,
                          5 * heightRatio,
                          5 * heightRatio,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '프로필 사진 수정',
                          style: TextStyle(
                            fontSize: 13 * heightRatio,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                         
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(30),
                        child: InkWell(
                          onTap: () async {
                            GoRouter.of(context).go('/home');
                          },
                          child: Text(
                            "로그아웃",
                            style: TextStyle(
                              color: Color(0xFFFF0000),
                              fontSize: 13 * heightRatio,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
