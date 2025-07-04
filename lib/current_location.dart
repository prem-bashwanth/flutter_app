import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  print("hhhh");
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}