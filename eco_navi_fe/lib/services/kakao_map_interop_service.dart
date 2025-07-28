// lib/kakao_map_web.dart

@JS('kakao.maps') // JS interop용
library kakao_maps;

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:web/web.dart';

@JS('Map')
@staticInterop
class KakaoMap {}

extension KakaoMapExt on KakaoMap {
  external void setCenter(LatLng pos);
  external LatLng getCenter();

  external void setDraggable(bool bool);

  external void setZoomable(bool bool);
}

// kakao.maps.LatLng
@JS('LatLng')
@staticInterop
class LatLng {}

extension LatLngExt on LatLng {
  /// 위도 반환
  external double getLat();

  /// 경도 반환
  external double getLng();
}

/// LatLng 생성 헬퍼
LatLng createLatLng(num lat, num lng) {
  final latLngCtor = _jsConstructor(['kakao', 'maps', 'LatLng']);
  return js_util.callConstructor(latLngCtor, [lat, lng]) as LatLng;
}

/// MapOptions 객체 리터럴 생성
JSObject createMapOptions({required LatLng center, int level = 5}) {
  final opts = js_util.newObject();
  js_util.setProperty(opts, 'center', center);
  js_util.setProperty(opts, 'level', level);
  return opts;
}

/// 계층 경로를 따라가 JS Constructor 반환
Object _jsConstructor(List<String> path) {
  Object current = js_util.globalThis;
  for (final segment in path) {
    current = js_util.getProperty<Object?>(current, segment)!;
  }
  return current;
}

/// js_util.newObject() 의 정확한 반환 타입
typedef JSObject = Object;

@JS('Marker')
@staticInterop
class Marker {}

@JS('Size')
@staticInterop
class ISize {}

@JS('Point')
@staticInterop
class Point {}

@JS('MarkerIamge')
@staticInterop
class MarkerImage {}

Marker createMarker(
  LatLng position,
  KakaoMap map,
  String imageSrc,
  double imageSizeWidth,
  double imageSizeHeight,
) {
  final imageSizeCtor = KakoMapInterop.jsConstructor(['kakao', 'maps', 'Size']);
  final imageSize =
      js_util.callConstructor(imageSizeCtor, [imageSizeWidth, imageSizeHeight])
          as ISize;

  final imageOffCtor = KakoMapInterop.jsConstructor(['kakao', 'maps', 'Point']);
  final imageOffset =
      js_util.callConstructor(imageOffCtor, [
            imageSizeWidth / 2,
            imageSizeHeight / 2,
          ])
          as Point;

  final imageOption = js_util.newObject();
  js_util.setProperty(imageOption, 'offset', imageOffset);

  final imageCtor = KakoMapInterop.jsConstructor([
    'kakao',
    'maps',
    'MarkerImage',
  ]);
  final image =
      js_util.callConstructor(imageCtor, [imageSrc, imageSize, imageOption])
          as MarkerImage;

  final opts = js_util.newObject();
  js_util.setProperty(opts, 'image', image);
  js_util.setProperty(opts, 'position', position);
  js_util.setProperty(opts, 'map', map);

  final ctor = KakoMapInterop.jsConstructor(['kakao', 'maps', 'Marker']);
  return js_util.callConstructor(ctor, [opts]) as Marker;
}

class KakoMapInterop {
  static Object jsConstructor(List<String> path) {
    Object current = js_util.globalThis;
    for (final segment in path) {
      current = js_util.getProperty<Object?>(current, segment)!;
    }
    return current;
  }

  static Future<void> loadKakaoSdk({
    required String apiKey,
    required VoidCallback onReady,
  }) async {
    // 이미 삽입되어 있으면 바로 콜백 등록
    if (document.getElementById('kakao-sdk') != null) {
      afterSdkLoaded(onReady);
    }

    // 1) autoload=false 로 SDK 삽입
    final script =
        HTMLScriptElement()
          ..id = 'kakao-sdk'
          ..defer = true
          ..src =
              'https://dapi.kakao.com/v2/maps/sdk.js?appkey=$apiKey&autoload=false';
    document.head!.append(script);

    // 2) onLoad 이벤트 → kakao.maps.load(cb)
    script.onLoad.listen((_) => afterSdkLoaded(onReady));
  }

  static void afterSdkLoaded(VoidCallback cb) {
    final kakaoObj = js_util.getProperty(js_util.globalThis, 'kakao');
    if (kakaoObj == null) {
      // 로딩 지연 대비
      Future.delayed(
        const Duration(milliseconds: 100),
        () => afterSdkLoaded(cb),
      );
      return;
    }
    final mapsObj = js_util.getProperty(kakaoObj, 'maps');
    js_util.callMethod(mapsObj, 'load', [js_util.allowInterop(cb)]);
  }
}

class KakaoSDKInitializer {
  static const _maxRetries = 5;
  static const _initialDelay = Duration(seconds: 1);
  static const _backoffFactor = 2;

  static Future<void> initializeWithRetry({
    required String apiKey,
    int retryCount = 0,
    Duration? delay,
  }) async {
    try {
      await KakoMapInterop.loadKakaoSdk(
        apiKey: apiKey,
        onReady: () => print('Kakao SDK 초기화 성공'),
      );

      // 실제 로드 여부 검증
      if (!_isSDKLoaded()) {
        throw Exception('SDK 객체 존재하지 않음');
      }
    } catch (e, stack) {
      print('초기화 실패 (시도 $retryCount): $e\n$stack');

      if (retryCount >= _maxRetries) {
        throw TimeoutException('최대 재시도 횟수 초과', _maxRetries as Duration?);
      }

      final nextDelay = delay ?? _initialDelay;
      await Future.delayed(nextDelay);

      return initializeWithRetry(
        apiKey: apiKey,
        retryCount: retryCount + 1,
        delay: nextDelay * _backoffFactor,
      );
    }
  }

  static bool _isSDKLoaded() {
    final g = js_util.globalThis;
    return js_util.hasProperty(g, 'kakao') &&
        js_util.hasProperty(js_util.getProperty(g, 'kakao'), 'maps');
  }
}

//////////////////////////////////////////////////////////////////////////

@JS('Kakao')
external JSAny get Kakao;

class KakaoAuthLoader {
  static const _scriptId = 'kakao-auth-sdk';
  static const _sdkSrc =
      'https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js';
  static bool _isInitialized = false;

  static bool _isLoaded() => js_util.hasProperty(js_util.globalThis, 'Kakao');

  /// SDK 삽입 + Kakao.init(jsAppKey)
  static Future<void> load({required String jsAppKey}) async {
    if (_isInitialized) return;

    try {
      // 1) 이미 로드되었는지 확인
      if (_isLoaded()) {
        _initializeKakao(jsAppKey);
        return;
      }

      // 2) <script> 태그 생성 및 삽입
      final completer = Completer<void>();
      final script =
          HTMLScriptElement()
            ..id = _scriptId
            ..type = 'text/javascript'
            ..src = _sdkSrc
            ..integrity =
                'sha384-6MFdIr0zOira1CHQkedUqJVql0YtcZA1P0nbPrQYJXVJZUkTk/oX4U9GhUIs3/z8'
            ..crossOrigin = 'anonymous';

      // 3) 로드 완료 이벤트 핸들러
      script.onLoad.listen((_) {
        _initializeKakao(jsAppKey);
        completer.complete();
      });

      // 4) 에러 핸들러
      script.onError.listen((event) {
        completer.completeError('Failed to load Kakao SDK: ${event.type}');
      });

      // 5) <script> 태그 삽입
      document.head!.append(script);
      await completer.future;
    } catch (e) {
      print('Kakao SDK 로드 실패: $e');
      rethrow;
    }
  }

  static void _initializeKakao(String jsAppKey) {
    if (!_isInitialized) {
      final kakao = js_util.getProperty(js_util.globalThis, 'Kakao');
      js_util.callMethod(kakao, 'init', [jsAppKey]);
      _isInitialized = true;
      print('Kakao SDK initialized successfully');
    }
  }
}
