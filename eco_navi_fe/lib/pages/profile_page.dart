import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String user;
  late final int ecoPoint;
  //Map<String, dynamic>? membershipData;
  bool isLoading = true;

  Future<Map<String, dynamic>?> loadJson(String classIdx) async {
    final String jsonString = await rootBundle.loadString(
      'config/membershp_table.json',
    );
    final jsonData = await json.decode(jsonString);

    try {
      setState(() {
        isLoading = false;
      });

      return jsonData[classIdx];
    } catch (e) {
      print('Error loading membership data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    user = 'User'; //User 이름 받아오기
    ecoPoint = 100; //User의 EcoPoint 받아오기

    loadJson("0"); //User의 membership 인덱스 받아와서 키검색

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

    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: loadJson("0"),
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
                    18 * heightRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 70 * heightRatio,
                        width: 70 * heightRatio,
                      ),
                      Center(
                        child: Text(
                          '프로필',
                          style: TextStyle(
                            fontSize: 24 * heightRatio,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 70 * heightRatio,
                        width: 70 * heightRatio,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).go('/profile/setting');
                              },
                              child: Container(
                                height: 24 * heightRatio,
                                width: 24 * heightRatio,
                                child: SvgPicture.asset(
                                  'svg/frame.svg',
                                  height: 20 * heightRatio,
                                  width: 20 * heightRatio,
                                  colorFilter: ColorFilter.mode(
                                    Color(0xFF000000),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 24 * heightRatio,
                                width: 24 * heightRatio,
                                child: SvgPicture.asset(
                                  'svg/bell.svg',
                                  width: 24 * heightRatio,
                                  height: 24 * heightRatio,
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
                    ],
                  ),
                ),

                Container(
                  height: 37 * heightRatio,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 37 * heightRatio,
                        width: 37 * heightRatio,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          user,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${snapshot.data?['class']} 등급 >",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Color(
                              int.parse(
                                "0xFF${snapshot.data?["primary_color"]}",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 42,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    20 * heightRatio,
                    0 * heightRatio,
                    20 * heightRatio,
                    0 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        "0x4D${snapshot.data?["background_color"]}",
                      ) /*0x4DFFDAD7*/,
                    ),
                    border: Border.all(
                      color: Color(
                        int.parse(
                          "0xB3${snapshot.data?["border_color"]}",
                        ) /*0xB3FF8276*/,
                      ),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${snapshot.data?['class']}\t\t\t|\t\t\t",
                        style: TextStyle(
                          color: Color(
                            int.parse("0xFF${snapshot.data?["primary_color"]}"),
                          ),
                          fontSize: 14 * heightRatio,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      Text(
                        "${snapshot.data?['content']} >",
                        style: TextStyle(
                          fontSize: 12 * heightRatio,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 145 * heightRatio,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    15 * heightRatio,
                    15 * heightRatio,
                    15 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "보유 포인트",
                            style: TextStyle(
                              fontSize: 12 * heightRatio,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${ecoPoint}P",
                            style: TextStyle(
                              fontSize: 32 * heightRatio,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 27 * heightRatio,
                              width: 40 * heightRatio,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "수정",
                                style: TextStyle(
                                  fontSize: 12 * heightRatio,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 108 * heightRatio,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    15 * heightRatio,
                    15 * heightRatio,
                    15 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //GoRouter.of(context).go('/map');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'svg/tmp_box.svg',
                                height: 26 * heightRatio,
                                width: 26 * heightRatio,
                              ),
                              Container(height: 10 * heightRatio),
                              Text(
                                '관람 내역',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(height: 3 * heightRatio),
                              Text(
                                '00',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //GoRouter.of(context).go('/map');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'svg/tmp_box.svg',
                                height: 26 * heightRatio,
                                width: 26 * heightRatio,
                              ),
                              Container(height: 10 * heightRatio),
                              Text(
                                '리뷰',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(height: 3 * heightRatio),
                              Text(
                                '00',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //GoRouter.of(context).go('/map');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'svg/tmp_box.svg',
                                height: 26 * heightRatio,
                                width: 26 * heightRatio,
                              ),
                              Container(height: 10 * heightRatio),
                              Text(
                                '문의',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(height: 3 * heightRatio),
                              Text(
                                '00',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //GoRouter.of(context).go('/map');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'svg/tmp_box.svg',
                                height: 26 * heightRatio,
                                width: 26 * heightRatio,
                              ),
                              Container(height: 10 * heightRatio),
                              Text(
                                '쿠폰',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(height: 3 * heightRatio),
                              Text(
                                '00장',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //GoRouter.of(context).go('/map');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'svg/tmp_box.svg',
                                height: 26 * heightRatio,
                                width: 26 * heightRatio,
                              ),
                              Container(height: 10 * heightRatio),
                              Text(
                                '포인트',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Container(height: 3 * heightRatio),
                              Text(
                                '00000원',
                                style: TextStyle(
                                  fontSize: 11 * heightRatio,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
