import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'svg/eco_navi_text_logo.svg',
                  height: 23 * heightRatio,
                  width: 143 * heightRatio,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
