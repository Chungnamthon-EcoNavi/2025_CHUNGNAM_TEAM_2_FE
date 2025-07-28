import 'dart:math';

import 'package:eco_navi_fe/models/place.dart';

class PlaceLocator {
  final List<Place> places;

  PlaceLocator(this.places);

  /// 현재 좌표와 가장 가까운 n개의 Place 반환
  List<Place> getNearestPlaces({
    required double currentLatitude,
    required double currentLongitude,
    required int count,
  }) {
    final sorted =
        places.toList()..sort((a, b) {
          final distA = _calculateDistance(
            currentLatitude,
            currentLongitude,
            a.latitude,
            a.longitude,
          );
          final distB = _calculateDistance(
            currentLatitude,
            currentLongitude,
            b.latitude,
            b.longitude,
          );
          return distA.compareTo(distB);
        });

    return sorted.take(count).toList();
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371; // km
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degree) => degree * pi / 180;
}
