import 'package:eco_navi_fe/models/place.dart';
import 'package:eco_navi_fe/pages/suggestion_page.dart';
import 'package:eco_navi_fe/services/econavi_api_service.dart';
import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:eco_navi_fe/views/suggestion_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final _formKey1 = GlobalKey<FormState>();
  KakaoMapController? _controller;

  List<Place> places = List.empty(growable: true);
  bool _isMarkerSelected = false;
  Map<String, dynamic>? _selectedinfo;

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  double _sheetFraction = 13 / 402;

  final FocusNode _node = FocusNode();

  late String _textVal;

  int _filterSelected = 0;
  int _filterIndex = 0;

  @override
  void initState() {
    _node.addListener(() => setState(() {}));

    sheetController.addListener(() {
      setState(() {
        _sheetFraction = sheetController.size; // 현재 바텀시트의 비율값
      });
    });

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

    return Stack(
      children: [
        //map
        KakaoMapView(
          draggable: true,
          zoomable: true,
          displayUserLoc: true,
          borderRadius: 0,
          tag: 'Map',
          onMapReady: (controller) {
            setState(() => _controller = controller);
            getAroundPlaceResult(heightRatio: heightRatio, distance: 100.0);
            /**controller.addMarker(
                controller.getCenter().$1,
                controller.getCenter().$2,
                {'id': 'test'},
                26 * heightRatio,
                26 * heightRatio,
              ); */

            controller.startUserLocationTracking(
              'assets/svg/trip_origin.svg',
              24 * heightRatio,
              24 * heightRatio,
            );
          },
        ),

        _customMapWidget(size),

        Positioned(
          bottom:
              13 * heightRatio +
              (_sheetFraction * size.height * 0.8), // 시트 높이만큼 버튼 위로 이동
          left: 13 * heightRatio,
          child: Opacity(
            opacity: _sheetFraction < 0.5 ? 1.0 : 0.0,
            child: _currentMyLoc(size),
          ),
        ),

        _mapBottomSheet(size),
      ],
    );
  }

  _customMapWidget(Size size) {
    final width = size.height * (402 / 874);
    final double heightRatio = size.height / 874;

    final bool focused = _node.hasFocus;
    return //TextFormField for Searching and Conatiners with keywords
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
                        onFieldSubmitted: (value) {
                          print(value);
                          getSearchPlaceResult(
                            keyword: value,
                            heightRatio: heightRatio,
                          );
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
    );
  }

  _currentMyLoc(Size size) {
    final width = size.height * (402 / 874);
    final double heightRatio = size.height / 874;
    return Column(
      children: [
        InkWell(
          onTap: () {
            print("click1");
            //_controller?.moveToCurrent();
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
              colorFilter: ColorFilter.mode(Color(0xFFFF6F61), BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  _mapBottomSheet(Size size) => DraggableScrollableSheet(
    initialChildSize: 0.03,
    maxChildSize: 0.9,
    minChildSize: 0.03,
    controller: sheetController,
    builder: (BuildContext context, scrollController) {
      final width = size.height * (402 / 874);
      final double heightRatio = size.height / 874;

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
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF949494),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 4 * heightRatio,
                  width: 31 * heightRatio,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: width,
                  height: 41 * heightRatio,
                  margin: EdgeInsets.fromLTRB(
                    25 * heightRatio,
                    0 * heightRatio,
                    25 * heightRatio,
                    10 * heightRatio,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    border: Border.all(
                      color: Color(0xFFB9B9B9),
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: _filterSelected % 2 == 0 ? 0 : null,
                        right: _filterSelected % 2 == 0 ? null : 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _filterSelected = (_filterSelected + 1) % 2;
                            });
                          },
                          child: Container(
                            width: 185 * heightRatio,
                            height: 41 * heightRatio,
                            decoration: BoxDecoration(
                              color:
                                  _filterSelected % 2 == 0
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFFD9D9D9),
                              border: Border.all(
                                color: Color(0xFFB9B9B9),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'png/filter.png',
                                  height: 20 * heightRatio,
                                  width: 20 * heightRatio,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    5 * heightRatio,
                                    0 * heightRatio,
                                    0 * heightRatio,
                                    0 * heightRatio,
                                  ),
                                  child: Text(
                                    "필터 ${_filterSelected == 0 ? "ON" : "OFF"}",
                                    style: TextStyle(
                                      fontSize: 16 * heightRatio,
                                      fontWeight: FontWeight.w300,
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
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
              ),
            ),

            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: width,
                  height: 41 * heightRatio,
                  margin: EdgeInsets.fromLTRB(
                    25 * heightRatio,
                    0 * heightRatio,
                    25 * heightRatio,
                    10 * heightRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_filterIndex == 1) {
                                _filterIndex = 0;
                              } else {
                                _filterIndex = 1;
                              }
                            });
                          },
                          child: Container(
                            height: 41 * heightRatio,
                            width: 75 * heightRatio,
                            decoration: BoxDecoration(
                              color:
                                  _filterIndex == 1
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFFEFEFEF),
                              border: Border.all(
                                color: Color(0xFFB9B9B9),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Eco Point",
                              style: TextStyle(
                                fontSize: 13 * heightRatio,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_filterIndex == 2) {
                                _filterIndex = 0;
                              } else {
                                _filterIndex = 2;
                              }
                            });
                          },
                          child: Container(
                            height: 41 * heightRatio,
                            width: 75 * heightRatio,
                            decoration: BoxDecoration(
                              color:
                                  _filterIndex == 2
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFFEFEFEF),
                              border: Border.all(
                                color: Color(0xFFB9B9B9),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "전시/공연",
                              style: TextStyle(
                                fontSize: 13 * heightRatio,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_filterIndex == 3) {
                                _filterIndex = 0;
                              } else {
                                _filterIndex = 3;
                              }
                            });
                          },
                          child: Container(
                            height: 41 * heightRatio,
                            width: 75 * heightRatio,
                            decoration: BoxDecoration(
                              color:
                                  _filterIndex == 3
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFFEFEFEF),
                              border: Border.all(
                                color: Color(0xFFB9B9B9),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "행사",
                              style: TextStyle(
                                fontSize: 13 * heightRatio,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_filterIndex == 4) {
                                _filterIndex = 0;
                              } else {
                                _filterIndex = 4;
                              }
                            });
                          },
                          child: Container(
                            height: 41 * heightRatio,
                            width: 75 * heightRatio,
                            decoration: BoxDecoration(
                              color:
                                  _filterIndex == 4
                                      ? Color(0xFFFF6F61)
                                      : Color(0xFFEFEFEF),
                              border: Border.all(
                                color: Color(0xFFB9B9B9),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "거리",
                              style: TextStyle(
                                fontSize: 13 * heightRatio,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverList.list(
              children: List.generate(
                3,
                (i) => SuggestionListView(
                  height: 70 * heightRatio,
                  width: width,
                  heightRatio: heightRatio,
                  name: "전시회",
                  adrr: "address",
                  date: "2025.00.00",
                  imageSrc: "",
                  content: "",
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  void getAroundPlaceResult({
    double distance = 1.0,
    required double heightRatio,
  }) async {
    Position pos = await Geolocator.getCurrentPosition();
    List<Place> data = await PlaceApiService.getPlace(
      lat: pos.latitude,
      lng: pos.longitude,
      distance: distance,
    );
    setState(() {
      places
        ..clear()
        ..addAll(data);
    });

    _controller?.clearMarkers();
    for (Place e in places) {
      //print(e.name);

      _controller?.addMarker(
        e.latitude,
        e.longitude,
        e.toJson(),
        26 * heightRatio,
        26 * heightRatio,
      );
    }
  }

  void getSearchPlaceResult({
    required String keyword,
    required double heightRatio,
  }) async {
    List<Place> data = await PlaceApiService.keywordSearch(keyword: keyword);
    setState(() {
      places
        ..clear()
        ..addAll(data);
    });

    _controller?.clearMarkers();
    for (Place e in places) {
      //print(e.name);

      _controller?.addMarker(
        e.latitude,
        e.longitude,
        e.toJson(),
        26 * heightRatio,
        26 * heightRatio,
      );
    }
  }
}

class PlaceInfo extends StatefulWidget {
  final Map<String, dynamic>? info;
  bool isSelected = false;
  PlaceInfo(this.info, {super.key, required this.isSelected});

  @override
  State<PlaceInfo> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isSelected,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
