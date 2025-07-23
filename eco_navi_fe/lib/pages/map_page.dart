import 'package:eco_navi_fe/views/kakao_map_view.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return KakaoMapView(
      draggable: true,
      zoomable: true,
      borderRadius: 0,
      tag: 'Map',
    );
  }
}
