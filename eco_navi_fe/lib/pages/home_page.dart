import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70 * heightRatio,
            width: 360 * heightRatio,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'svg/eco_navi_text_logo.svg',
                  height: 23 * heightRatio,
                  width: 143 * heightRatio,
                ),
                SvgPicture.asset(
                  'svg/bell.svg',
                  height: 26 * heightRatio,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF000000),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 50 * heightRatio, 0, 0),
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 255 * heightRatio,
                  width: 360 * heightRatio,
                  child: KakaoMapView(
                    draggable: false,
                    zoomable: false,
                    displayUserLoc: false,
                    borderRadius: 0,
                    tag: 'home_map',
                  ),
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).go('/map');
                  },
                  child: Container(
                    height: 255 * heightRatio,
                    width: 360 * heightRatio,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 66 * heightRatio,
            width: 360 * heightRatio,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(9),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
            height: 70 * heightRatio,
            width: 360 * heightRatio,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(9),
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
                      children: [
                        SvgPicture.asset(
                          'svg/currency-coin-rubel.svg',
                          height: 34 * heightRatio,
                          width: 34 * heightRatio,
                        ),
                        Container(height: 10 * heightRatio),
                        Text(
                          'Eco포인트',
                          style: TextStyle(
                            fontSize: 12 * heightRatio,
                            fontWeight: FontWeight.w500,
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
                      GoRouter.of(context).go('/suggestion');
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'svg/star.svg',
                          height: 34 * heightRatio,
                          width: 34 * heightRatio,
                        ),
                        Container(height: 10 * heightRatio),
                        Text(
                          '주변 추천',
                          style: TextStyle(
                            fontSize: 12 * heightRatio,
                            fontWeight: FontWeight.w500,
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
                      GoRouter.of(context).go('/map');
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'svg/map.svg',
                          height: 34 * heightRatio,
                          width: 34 * heightRatio,
                        ),
                        Container(height: 10 * heightRatio),
                        Text(
                          '지도',
                          style: TextStyle(
                            fontSize: 12 * heightRatio,
                            fontWeight: FontWeight.w500,
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
                      GoRouter.of(context).go('/search');
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'svg/image-question.svg',
                          height: 34 * heightRatio,
                          width: 34 * heightRatio,
                        ),
                        Container(height: 10 * heightRatio),
                        Text(
                          '검색',
                          style: TextStyle(
                            fontSize: 12 * heightRatio,
                            fontWeight: FontWeight.w500,
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
