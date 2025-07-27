import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final String user;
  late final int ecoPoint;
  //Map<String, dynamic>? membershipData;
  bool isLoading = true;

  Future<void> loadSomething() async {
    final String jsonString = await rootBundle.loadString(
      'config/membershp_table.json',
    );
    final jsonData = await json.decode(jsonString);

    try {
      setState(() {
        isLoading = false;
      });
      return jsonData["0"];
    } catch (e) {
      print('Error loading membership data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
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
        future: loadSomething(),
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
                          '설정',
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
                  height: 50 * heightRatio,
                  width: width,
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    8 * heightRatio,
                    15 * heightRatio,
                    8 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    10 * heightRatio,
                    0 * heightRatio,
                    10 * heightRatio,
                    20 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '계정 관리',
                    style: TextStyle(
                      fontSize: 20 * heightRatio,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 48 * heightRatio,
                              width: width,
                              margin: EdgeInsets.fromLTRB(
                                15 * heightRatio,
                                8 * heightRatio,
                                15 * heightRatio,
                                8 * heightRatio,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "프로필 수정",
                                    style: TextStyle(
                                      fontSize: 16 * heightRatio,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  Container(
                                    height: 16 * heightRatio,
                                    width: 16 * heightRatio,
                                    child: SvgPicture.asset(
                                      'svg/chevron-right.svg',
                                      height: 16 * heightRatio,
                                      width: 16 * heightRatio,
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFF000000),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 48 * heightRatio,
                              width: width,
                              margin: EdgeInsets.fromLTRB(
                                15 * heightRatio,
                                8 * heightRatio,
                                15 * heightRatio,
                                8 * heightRatio,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "관리자 신청",
                                    style: TextStyle(
                                      fontSize: 16 * heightRatio,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  Container(
                                    height: 16 * heightRatio,
                                    width: 16 * heightRatio,
                                    child: SvgPicture.asset(
                                      'svg/chevron-right.svg',
                                      height: 16 * heightRatio,
                                      width: 16 * heightRatio,
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFF000000),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 48 * heightRatio,
                              width: width,
                              margin: EdgeInsets.fromLTRB(
                                15 * heightRatio,
                                8 * heightRatio,
                                15 * heightRatio,
                                8 * heightRatio,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                                10 * heightRatio,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "비밀번호 변경",
                                    style: TextStyle(
                                      fontSize: 16 * heightRatio,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  Container(
                                    height: 16 * heightRatio,
                                    width: 16 * heightRatio,
                                    child: SvgPicture.asset(
                                      'svg/chevron-right.svg',
                                      height: 16 * heightRatio,
                                      width: 16 * heightRatio,
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFF000000),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(30),
                        child: InkWell(
                          onTap: () {},
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
