// import 'dart:collection';

// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:stacked/stacked.dart';

// class ChatMapViewModel extends BaseViewModel {
//   CameraPosition? currentCameraPosition;
//   Position? currentPosition;
//   bool? _location = false;

//   bool? get location => _location;

//   set location(bool? value) {
//     _location = value;
//     notifyListeners();
//   }

//   final Set<Marker> markers = HashSet<Marker>();

//   void getCurrentLocation() async {
//     var permissionStatus = await Permission.location.request();
//     if (permissionStatus.isDenied) {
//       await [Permission.location].request();
//     }
//     currentPosition ??= await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     if (currentPosition != null) {
//       var latlang =
//           LatLng(currentPosition!.latitude, currentPosition!.longitude);
//       markers.add(Marker(markerId: MarkerId('0'), position: latlang));
//       currentCameraPosition ??= CameraPosition(target: latlang, zoom: 17);
//     }
//     location = true;
//   }

//   void addMarker(Marker marker) {
//     markers.clear();
//     markers.add(marker);
//     notifyListeners();
//   }

//   void initialize() async {
//     getCurrentLocation();
//   }
// }
