import 'dart:async';
import 'dart:ui_web' as ui;
import 'package:eco_navi_fe/services/kakao_map_interop_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:web/web.dart' as dom;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef ValueChanged<T> = void Function(T newValue);

class KakaoMapController {
  KakaoMapController._(this._state);
  final _KakaoMapViewState _state;

  void addMarker(double lat, double lng, Map<String, dynamic> info) {
    _state._addMarker(createLatLng(lat, lng), info);
  }

  void clearMarkers() => _state._clearMarkers();

  (double, double) getCenter() => _state._getCenter();

  bool getIsMarkerSelected() => _state._getIsMarkerSelected();

  Map<String, dynamic>? getSelectedInfo() => _state._getSelectedInfo();
}

class KakaoMapView extends StatefulWidget {
  const KakaoMapView({
    super.key,
    required this.draggable,
    required this.zoomable,
    required this.borderRadius,
    required this.tag,
    this.onMapReady,
    this.onChanged,
  });
  final bool draggable;
  final bool zoomable;
  final double borderRadius;

  final String tag;

  final ValueChanged<Map<String, dynamic>?>? onChanged;

  final void Function(KakaoMapController controller)? onMapReady;

  @override
  State<KakaoMapView> createState() => _KakaoMapViewState();
}

class _KakaoMapViewState extends State<KakaoMapView>
    with AutomaticKeepAliveClientMixin<KakaoMapView> {
  final _htmlId = 'kakao-map-${DateTime.now().millisecondsSinceEpoch}';

  late KakaoMap _map;
  final List<Marker> _markers = <Marker>[];
  bool flag = false;

  Map<String, dynamic>? _selectedInfo;
  bool _isMarkerseleted = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // 뷰팩토리 등록
    ui.platformViewRegistry.registerViewFactory(_htmlId, (int viewId) {
      final div =
          dom.HTMLDivElement()
            ..id = _htmlId
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.borderRadius = '${widget.borderRadius}px';
      return div;
    });

    KakoMapInterop.loadKakaoSdk(
      apiKey: dotenv.get("KAKAO_JAVASCRIPTKEY"),
      onReady: _initMap,
    );
  }

  Future<void> ensureKakaoLoaded() async {
    final g = js_util.globalThis;
    if (js_util.hasProperty(g, 'kakao') &&
        js_util.hasProperty(js_util.getProperty(g, 'kakao'), 'maps')) {
      return;
    }
    final c = Completer<void>();
    final maps = js_util.getProperty(js_util.getProperty(g, 'kakao'), 'maps');
    js_util.callMethod(maps, 'load', [
      js_util.allowInterop(() => c.complete()),
    ]);
    await c.future;
  }

  Future<void> _initMap() async {
    //await ensureKakaoLoaded();
    try {
      if (!flag) {
        await KakaoSDKInitializer.initializeWithRetry(
          apiKey: dotenv.get("KAKAO_JAVASCRIPTKEY"),
        );
        final pos = await Geolocator.getCurrentPosition();
        final container = dom.document.getElementById(_htmlId)!;

        final center = createLatLng(pos.latitude, pos.longitude);
        final opts = createMapOptions(center: center, level: 5);

        final mapCtor = KakoMapInterop.jsConstructor(['kakao', 'maps', 'Map']);
        _map = js_util.callConstructor(mapCtor, [container, opts]) as KakaoMap;

        _map.setDraggable(widget.draggable);
        _map.setZoomable(widget.zoomable);
        _map.setCenter(center);

        widget.onMapReady?.call(KakaoMapController._(this));
        flag = !flag;
      }
    } catch (e) {
      debugPrint('최종 초기화 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _initMap(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return HtmlElementView(viewType: _htmlId);
      },
    );
  }

  (double, double) _getCenter() {
    LatLng center = _map.getCenter();
    return (center.getLat(), center.getLng());
  }

  void _addMarker(LatLng pos, Map<String, dynamic> info) {
    // info 관련해서 수정필요. 이벤트도.
    final map = _map;
    final m = createMarker(pos, map);

    js_util.callMethod(m, 'setMap', [map]);
    _markers.add(m);
    print(_markers);

    final kakao = js_util.getProperty(js_util.globalThis, 'kakao');
    final maps = js_util.getProperty(kakao, 'maps');
    final event = js_util.getProperty(maps, 'event');
    js_util.callMethod(event, 'addListener', [
      m,
      'click',
      js_util.allowInterop(
        (e) => _onMarkerTapped(info), //_onMarkerClicked(m, info)
      ),
    ]);
  }

  void _onMarkerTapped(Map<String, dynamic> info) {
    setState(() {
      _selectedInfo = info;
      _isMarkerseleted = true;

      widget.onChanged?.call(_selectedInfo);
    });
  }

  bool _getIsMarkerSelected() {
    return _isMarkerseleted;
  }

  Map<String, dynamic>? _getSelectedInfo() {
    return _selectedInfo;
  }

  void _onMarkerClicked(Marker clickedMarker, Map<String, dynamic> info) {
    final content = '''
    <div style="
      padding: 10px;
      background: white;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    ">
      <strong>${info['place_name']}</strong><br>
      id:${info['id']}<br>x:${info['x']}<br>y:${info['y']}
    </div>
  ''';

    final infowindowCtor = KakoMapInterop.jsConstructor([
      'kakao',
      'maps',
      'InfoWindow',
    ]);
    final opts = js_util.jsify({'content': content});
    final infowindow = js_util.callConstructor(infowindowCtor, [opts]);

    // 클릭된 마커에 인포윈도우 연결
    js_util.callMethod(infowindow, 'open', [_map, clickedMarker]);
  }

  void _clearMarkers() {
    // 모든 마커를 지도에서 제거
    for (final marker in _markers) {
      js_util.callMethod(marker, 'setMap', [null]);
    }

    // 리스트 초기화
    _markers.clear();
  }
}
