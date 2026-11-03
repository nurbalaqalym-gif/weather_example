import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      // Телефонның орналасқан жерін анықтаймыз.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Ендік пен бойлықты сақтаймыз.
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Something goes wrong: $e');
      rethrow;
    }
  }
}
