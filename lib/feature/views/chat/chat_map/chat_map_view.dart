// import 'dart:async';

// import 'package:c21estate/core/components/button.dart';
// import 'package:c21estate/core/components/custom_header.dart';
// import 'package:c21estate/core/components/progress_indicator_bar.dart';
// import 'package:c21estate/core/components/text/custom_text.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../core/components/custom_back_button.dart';
// import 'chat_map_view_model.dart';

// class ChatMapView extends StatelessWidget {
//   ChatMapView({Key? key}) : super(key: key);
//   final _controller = Completer();

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<ChatMapViewModel>.reactive(
//         viewModelBuilder: () => ChatMapViewModel(),
//         onModelReady: (viewModel) => viewModel.initialize(),
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             appBar: CustomHeader(
//                 CustomText('Konum Gönder',
//                     color: Color(0xff818181), fontSize: 15),
//                 CustomBackButton(),
//                 [
//                   TextButton(onPressed: (){
//                     Navigator.pop(context, viewModel.markers.first);
//                   }, child: CustomText('Gönder'))
//                 ],
//                 true),
//             body: viewModel.currentCameraPosition != null
//                 ? GoogleMap(
//                     initialCameraPosition: viewModel.currentCameraPosition!,
//                     onMapCreated: (GoogleMapController controller) {
//                       if (!_controller.isCompleted) {
//                         _controller.complete(controller);
//                       }
//                     },
//                     myLocationEnabled: true,
//                     markers: viewModel.markers,
//                     onTap: (latlang) {
//                       print(latlang);
//                       viewModel.addMarker(Marker(
//                           draggable: true,
//                           markerId: MarkerId('0'),
//                           position: latlang));
//                     },
//                     /*gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//             Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
//           }*/
//                   )
//                 : ProgressIndicatorWidget(),
//           );
//         });
//   }
// }
