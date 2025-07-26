import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
            height: 30 * heightRatio,
            width: width,
            margin: EdgeInsets.fromLTRB(
              15 * heightRatio,
              40 * heightRatio,
              15 * heightRatio,
              0 * heightRatio,
            ),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
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
            margin: EdgeInsets.fromLTRB(
              0 * heightRatio,
              50 * heightRatio,
              0 * heightRatio,
              0 * heightRatio,
            ),
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 255 * heightRatio,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.fromLTRB(
                    15 * heightRatio,
                    0 * heightRatio,
                    15 * heightRatio,
                    0 * heightRatio,
                  ),
                  child: KakaoMapView(
                    draggable: false,
                    zoomable: false,
                    displayUserLoc: false,
                    borderRadius: 4,
                    tag: 'home_map',
                  ),
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).go('/map');
                  },
                  child: Container(
                    height: 255 * heightRatio,
                    width: width,
                    margin: EdgeInsets.fromLTRB(
                      15 * heightRatio,
                      0 * heightRatio,
                      15 * heightRatio,
                      0 * heightRatio,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 66 * heightRatio,
            width: width,
            margin: EdgeInsets.fromLTRB(
              15 * heightRatio,
              10 * heightRatio,
              15 * heightRatio,
              0 * heightRatio,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(9),
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(
              0 * heightRatio,
              10 * heightRatio,
              0 * heightRatio,
              10 * heightRatio,
            ),
            height: 90 * heightRatio,
            width: width,
            margin: EdgeInsets.fromLTRB(
              15 * heightRatio,
              20 * heightRatio,
              15 * heightRatio,
              20 * heightRatio,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(9),
              border: Border(
                top: BorderSide(color: Color(0xFFE9E9E9)),
                bottom: BorderSide(color: Color(0xFFE9E9E9)),
              ),
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
                      GoRouter.of(context).go('/home/image_search');
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
                          '이미지 검색',
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

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 158 * heightRatio,
                  width: 169 * heightRatio,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 158 * heightRatio,
                  width: 169 * heightRatio,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4),
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
