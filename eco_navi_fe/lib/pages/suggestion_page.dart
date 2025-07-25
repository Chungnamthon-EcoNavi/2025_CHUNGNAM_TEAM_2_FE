import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:flutter/material.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
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
      child: Stack(
        children: [
          KakaoMapView(
            draggable: true,
            zoomable: true,
            displayUserLoc: false,
            borderRadius: 0,
            tag: 'suggestion',
          ),
        ],
      ),
    );
  }
}
