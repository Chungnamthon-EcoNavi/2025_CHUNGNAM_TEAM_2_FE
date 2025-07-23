import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _formKey1 = GlobalKey<FormState>();
  KakaoMapController? _controller;

  final FocusNode _node = FocusNode();

  late String _textVal;

  @override
  void initState() {
    _node.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.height * (402 / 874);
    final double heightRatio = size.height / 874;

    final bool focused = _node.hasFocus;

    return Stack(
      children: [
        //map
        KakaoMapView(
          draggable: true,
          zoomable: true,
          borderRadius: 0,
          tag: 'Map',
          onMapReady: (controller) {
            setState(() => _controller = controller);
          },
        ),

        //Button for MoveToCurrentLocation
        Positioned(
          bottom: 0 * heightRatio,
          left: 0 * heightRatio,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _controller?.moveToCurrent();
                },
                child: Container(
                  height: 42 * heightRatio,
                  width: 42 * heightRatio,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                    13 * heightRatio,
                    0,
                    0,
                    13 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFFF6F61),
                      width: 2 * heightRatio,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                ),
              ),

              //Button for moving Center of map to user location
              InkWell(
                onTap: () {
                  _controller?.moveToCurrent();
                },
                child: Container(
                  height: 42 * heightRatio,
                  width: 42 * heightRatio,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                    13 * heightRatio,
                    0,
                    0,
                    13 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFFF6F61),
                      width: 2 * heightRatio,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'svg/target.svg',
                    height: 24 * heightRatio,
                    colorFilter: ColorFilter.mode(
                      Color(0xFFFF6F61),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //TextFormField for Searching and Conatiners with keywords
        SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //TextFormField for Searching
              FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                child: Form(
                  key: _formKey1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      70 * heightRatio,
                      0,
                      20 * heightRatio,
                    ),
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 48 * heightRatio,
                    width: width * (370 / 402),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF9D9D9D),
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              print("clicked");
                            },
                            child: Image.asset(
                              'png/notice.png',
                              height: 21 * heightRatio,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 7,
                          child: TextFormField(
                            focusNode: _node,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: focused ? '' : '주변 문화활동/업사이클링 마켓 검색',
                              hintStyle: TextStyle(
                                color: Color(0xFFC4C4C4),
                                fontSize: 14 * heightRatio,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 18 * heightRatio,

                            onChanged:
                                (value) => setState(() {
                                  _textVal = value;
                                }),

                            onSaved: (newValue) {
                              _textVal = newValue!;
                              //검색 이벤트 발생
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'png/microphone.png',
                              height: 21 * heightRatio,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Conatiners with keywords
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 33 * heightRatio,
                        padding: EdgeInsets.fromLTRB(
                          30 * heightRatio,
                          5 * heightRatio,
                          30 * heightRatio,
                          5 * heightRatio,
                        ),
                        margin: EdgeInsets.fromLTRB(
                          10 * heightRatio,
                          0 * heightRatio,
                          5 * heightRatio,
                          0 * heightRatio,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6F61),
                          border: Border.all(
                            color: Color(0xFF808080),
                            width: 1 * heightRatio,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(67),
                        ),
                        child: Text(
                          "Eco point",
                          style: TextStyle(
                            color: Color(0xFF9D3B31),
                            fontSize: 14 * heightRatio,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 33 * heightRatio,
                        padding: EdgeInsets.fromLTRB(
                          15 * heightRatio,
                          5 * heightRatio,
                          15 * heightRatio,
                          5 * heightRatio,
                        ),
                        margin: EdgeInsets.fromLTRB(
                          10 * heightRatio,
                          0 * heightRatio,
                          5 * heightRatio,
                          0 * heightRatio,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFF808080),
                            width: 1 * heightRatio,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(67),
                        ),
                        child: Text(
                          "전시/공연",
                          style: TextStyle(
                            fontSize: 14 * heightRatio,
                            fontWeight: FontWeight.w500,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 33 * heightRatio,
                        padding: EdgeInsets.fromLTRB(
                          15 * heightRatio,
                          5 * heightRatio,
                          15 * heightRatio,
                          5 * heightRatio,
                        ),
                        margin: EdgeInsets.fromLTRB(
                          10 * heightRatio,
                          0 * heightRatio,
                          5 * heightRatio,
                          0 * heightRatio,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE4E4),
                          border: Border.all(
                            color: Color(0xFF808080),
                            width: 1 * heightRatio,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(67),
                        ),
                        child: Text(
                          "체험활동",
                          style: TextStyle(
                            fontSize: 14 * heightRatio,
                            fontWeight: FontWeight.w500,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 33 * heightRatio,
                        padding: EdgeInsets.fromLTRB(
                          15 * heightRatio,
                          5 * heightRatio,
                          15 * heightRatio,
                          5 * heightRatio,
                        ),
                        margin: EdgeInsets.fromLTRB(
                          10 * heightRatio,
                          0 * heightRatio,
                          5 * heightRatio,
                          0 * heightRatio,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          border: Border.all(
                            color: Color(0xFF808080),
                            width: 1 * heightRatio,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(67),
                        ),
                        child: Text(
                          "행사",
                          style: TextStyle(
                            fontSize: 14 * heightRatio,
                            fontWeight: FontWeight.w500,
                            textBaseline: TextBaseline.alphabetic,
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
      ],
    );
  }
}
