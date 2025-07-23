import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NaviScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const NaviScreen({super.key, required this.navigationShell});

  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

const Map<int, String> NAV_INDEX_ENDPOINT_MAPPER = {
  0: '/suggestion',
  1: '/map',
  2: '/home',
  3: '/store',
  4: '/profile',
};

class _NaviScreenState extends State<NaviScreen> {
  int currentIndex = 2;

  void onTapBottomNavigation(int index) {
    final hasAlreadyOnBranch = index == widget.navigationShell.currentIndex;
    if (hasAlreadyOnBranch) {
      context.go(NAV_INDEX_ENDPOINT_MAPPER[index]!);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initNavigationIndex(context);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        alignment: Alignment.topCenter,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onTapBottomNavigation(0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/heart.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 0
                                  ? Color(0xFFFF6F61)
                                  : Color(0xFF737373),
                              BlendMode.srcIn,
                            ),
                          ),

                          Text(
                            '추천',
                            style: TextStyle(
                              color:
                                  currentIndex == 0
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              currentIndex == 0
                                  ? Color(0xFFFF6F61)
                                  : Color(0x00737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onTapBottomNavigation(1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/marker.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 1
                                  ? Color(0xFFFF6F61)
                                  : Color(0xFF737373),
                              BlendMode.srcIn,
                            ),
                          ),

                          Text(
                            '지도',
                            style: TextStyle(
                              color:
                                  currentIndex == 1
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              currentIndex == 1
                                  ? Color(0xFFFF6F61)
                                  : Color(0x00737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onTapBottomNavigation(2),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/home.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 2
                                  ? Color(0xFFFF6F61)
                                  : Color(0xFF737373),
                              BlendMode.srcIn,
                            ),
                          ),

                          Text(
                            '홈',
                            style: TextStyle(
                              color:
                                  currentIndex == 2
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              currentIndex == 2
                                  ? Color(0xFFFF6F61)
                                  : Color(0x00737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onTapBottomNavigation(3),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/bag.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 3
                                  ? Color(0xFFFF6F61)
                                  : Color(0xFF737373),
                              BlendMode.srcIn,
                            ),
                          ),

                          Text(
                            '상점',
                            style: TextStyle(
                              color:
                                  currentIndex == 3
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              currentIndex == 3
                                  ? Color(0xFFFF6F61)
                                  : Color(0x00737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onTapBottomNavigation(4),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'svg/profile.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 4
                                  ? Color(0xFFFF6F61)
                                  : Color(0xFF737373),
                              BlendMode.srcIn,
                            ),
                          ),

                          Text(
                            '프로필',
                            style: TextStyle(
                              color:
                                  currentIndex == 4
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFF737373),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              currentIndex == 4
                                  ? Color(0xFFFF6F61)
                                  : Color(0x00737373),
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
    );
  }

  void _initNavigationIndex(BuildContext context) {
    final routerState = GoRouterState.of(context);
    late int index;
    for (final entry in NAV_INDEX_ENDPOINT_MAPPER.entries) {
      if (routerState.fullPath!.startsWith(entry.value)) {
        index = entry.key;
      }
    }
    setState(() => currentIndex = index);
  }
}
