import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:eco_navi_fe/views/suggestion_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  bool _isOpen = false;

  void _toggleSheet() {
    if (_isOpen) {
      sheetController.animateTo(
        0.03, // 닫혔을 때 비율
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      sheetController.animateTo(
        0.4, // 열렸을 때 비율 (원하는 크기)
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  double _sheetFraction = 13 / 402;

  @override
  void initState() {
    sheetController.addListener(() {
      setState(() {
        _sheetFraction = sheetController.size; // 현재 바텀시트의 비율값
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = height * (402 / 874);
    final double heightRatio = height / 874;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          KakaoMapView(
            draggable: true,
            zoomable: true,
            displayUserLoc: false,
            borderRadius: 0,
            tag: 'suggestion',
          ),

          //Container(color: Color(0xA6000000)),
          _suggBottomSheet(size),
        ],
      ),
    );
  }

  _suggBottomSheet(Size size) => DraggableScrollableSheet(
    initialChildSize: 0.05, // 닫힌 크기
    minChildSize: 0.05,
    maxChildSize: 0.4,
    snap: true,
    snapSizes: [],
    controller: sheetController,
    builder: (BuildContext context, scrollController) {
      final Size size = MediaQuery.of(context).size;
      final height = size.height;
      final width = height * (402 / 874);
      final double heightRatio = height / 874;

      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: width,
                height: 38 * heightRatio,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFB9B9B9), width: 1),
                  ),
                ),
                child: InkWell(
                  onTap: _toggleSheet,
                  child: Center(
                    child: SvgPicture.asset(
                      _isOpen ? 'svg/chevron-down.svg' : 'svg/chevron-up.svg',
                      height: 24 * heightRatio,
                      colorFilter: ColorFilter.mode(
                        Color(0xFF737373),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverList.list(
              children: [
                SuggestionListView(
                  height: 70 * heightRatio,
                  width: width,
                  heightRatio: heightRatio,
                  name: "전시회",
                  adrr: "address",
                  date: "2025.00.00",
                  imageSrc: "",
                  content: "",
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
