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
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => onTapBottomNavigation(0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color:
                            currentIndex == 0
                                ? Color(0xFFFF6F61)
                                : Color(0x00737373),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                  child: Column(
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
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => onTapBottomNavigation(1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color:
                            currentIndex == 1
                                ? Color(0xFFFF6F61)
                                : Color(0x00737373),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                  child: Column(
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
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => onTapBottomNavigation(2),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color:
                            currentIndex == 2
                                ? Color(0xFFFF6F61)
                                : Color(0x00737373),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                  child: Column(
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
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => onTapBottomNavigation(3),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color:
                            currentIndex == 3
                                ? Color(0xFFFF6F61)
                                : Color(0x00737373),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                  child: Column(
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
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () => onTapBottomNavigation(4),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color:
                            currentIndex == 4
                                ? Color(0xFFFF6F61)
                                : Color(0x00737373),
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                  child: Column(
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
                ),
              ),
            ),

            /*
                      
      BottomNavigationBar(
        currentIndex: currentIndex ?? 2,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        selectedItemColor: Color(0xFFFF6F61),
        unselectedItemColor: Color(0xFF737373),
        onTap: onTapBottomNavigation,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/heart.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? Color(0xFFFF6F61) : Color(0xFF737373),
                BlendMode.srcIn,
              ),
            ),
            label: '추천',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        currentIndex == 1
                            ? Color(0xFFFF6F61)
                            : Color(0xFF737373),
                    width: 2,
                  ),
                ),
              ),
              child: SvgPicture.asset(
                'assets/svg/marker.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? Color(0xFFFF6F61) : Color(0xFF737373),
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? Color(0xFFFF6F61) : Color(0xFF737373),
                BlendMode.srcIn,
              ),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bag.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? Color(0xFFFF6F61) : Color(0xFF737373),
                BlendMode.srcIn,
              ),
            ),
            label: '상점',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/user-profile-circle.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 4 ? Color(0xFFFF6F61) : Color(0xFF737373),
                BlendMode.srcIn,
              ),
            ),
            label: '프로필',
          ),
        ],
      ),
                      */
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
