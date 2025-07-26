import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String user;
  late final int ecoPoint;
  late final Future membership;

  static Future loadJson(String classIdx) async {
    final String jsonString = await rootBundle.loadString(
      'config/membershp_table.json',
    );
    final data = await json.decode(jsonString);
    return data[classIdx];
  }

  @override
  void initState() {
    user = 'User'; //User 이름 받아오기
    ecoPoint = 100; //User의 EcoPoint 받아오기

    membership = loadJson("0"); //User의 membership 인덱스 받아와서 키검색

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
        future: membership,
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
                              onTap: () {},
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
                          "${snapshot.data["class"]} 등급 >",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Color(int.parse(snapshot.data["color"])),
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
                  decoration: BoxDecoration(
                    color: Color(0x4DFFDAD7),
                    border: Border.all(color: Color(0xB3FF8276), width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data['calss'],
                        style: TextStyle(
                          color: Color(int.parse(snapshot.data["color"])),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
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
