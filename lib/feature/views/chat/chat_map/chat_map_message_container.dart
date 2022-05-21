// import 'dart:collection';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ChatMapMessageContainer extends StatefulWidget {
//   final double latitude;
//   final double longitude;
//   const ChatMapMessageContainer(this.latitude, this.longitude, {Key? key})
//       : super(key: key);

//   @override
//   State<ChatMapMessageContainer> createState() =>
//       _ChatMapMessageContainerState();
// }

// class _ChatMapMessageContainerState extends State<ChatMapMessageContainer> {
//   CameraPosition? currentCameraPosition;
//   final Set<Marker> markers = HashSet<Marker>();

//   @override
//   void initState() {
//     super.initState();
//     var latlang = LatLng(widget.latitude, widget.longitude);
//     markers.add(Marker(markerId: MarkerId('0'), position: latlang));
//     currentCameraPosition ??= CameraPosition(target: latlang, zoom: 17);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: context.dynamicHeight(0.3),
//       child: currentCameraPosition != null
//           ? GoogleMap(
//               initialCameraPosition: currentCameraPosition!,
//               onMapCreated: (GoogleMapController controller) {
//                 // if (!_controller.isCompleted) {
//                 //   _controller.complete(controller);
//                 // }
//               },
//               onTap: (value) async {
//                 if (Platform.isIOS) {
//                   await launch(
//                       'https://maps.apple.com/?q=${widget.latitude},${widget.longitude}',
//                       forceSafariVC: false);
//                 }
//               },
//               myLocationEnabled: true,
//               markers: markers,
//               // onTap: (latlang) {
//               //   print(latlang);
//               //   viewModel.addMarker(Marker(
//               //       draggable: true,
//               //       markerId: MarkerId('0'),
//               //       position: latlang));
//               // },
//               /*gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//             Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
//           }*/
//             )
//           : ProgressIndicatorWidget(),
//     );
//   }
// }
