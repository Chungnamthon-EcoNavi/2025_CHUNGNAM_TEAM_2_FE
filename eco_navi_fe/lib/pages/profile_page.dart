import 'dart:convert';

import 'package:eco_navi_fe/services/econavi_api_service.dart';
import 'package:eco_navi_fe/models/user.dart';
import 'package:eco_navi_fe/models/point.dart';
import 'package:eco_navi_fe/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late User user;
  late Point ecoPoint;
  late Map<String, dynamic> classData;
  bool isLoading = true;

  Future<void> loadData() async {
    try {
      final authData = await getAuthData();
      if (authData == null) {
        GoRouter.of(context).go('/login');
        return;
      }

      user = (await getUser())!;
      ecoPoint = await getPoint();
      classData = await json.decode('config/membership_table.json');

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading profile data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    //loadData();
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
      child:
          false
              ? FutureBuilder(
                future: loadData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      GoRouter.of(context).go('/setting');
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
                                user.name ?? "로그인 >",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${classData['class'] ?? "-"} 등급 >",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(
                                    int.parse(
                                      "0xFF${classData["primary_color"] ?? "FFFFFF"}",
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
                              "0x4D${classData["background_color"] ?? "D9D9D9"}",
                            ) /*0x4DFFDAD7*/,
                          ),
                          border: Border.all(
                            color: Color(
                              int.parse(
                                "0xB3${classData["border_color"] ?? "E9E9E9"}",
                              ) /*0xB3FF8276*/,
                            ),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${classData['class'] ?? "-"}\t\t\t|\t\t\t",
                              style: TextStyle(
                                color: Color(
                                  int.parse(
                                    "0xFF${classData["primary_color"] ?? "000000"}",
                                  ),
                                ),
                                fontSize: 14 * heightRatio,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            Text(
                              "${classData['content'] ?? "--"} >",
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
                                  "${ecoPoint.amount}P",
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
                },
              )
              : Column(
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
                    child: InkWell(
                      onTap: () {
                        GoRouter.of(context).push('/login');
                      },
                      child: Text(
                        "로그인 하시오. >",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                              " - P",
                              style: TextStyle(
                                fontSize: 32 * heightRatio,
                                fontWeight: FontWeight.w600,
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
                                  '-',
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
                                  '-',
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
                                  '-',
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
                                  '-장',
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
                                  '- 원',
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
              ),
    );
  }
}
