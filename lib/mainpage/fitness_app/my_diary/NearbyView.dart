import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Activity_List_Data.dart';

class NearbyView extends StatefulWidget {
  const NearbyView({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  _NearbyViewState createState() => _NearbyViewState();
}

class _NearbyViewState extends State<NearbyView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late List<ActivityListData> activityListData;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(
            duration: const Duration(milliseconds: 2000),
            vsync: this
        );
    animationController.forward();
    activityListData = ActivityListData.tabIconsList;

  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animationController!.value),
              0.0,
            ),
            child: NearbyViews(
              animationController: animationController,
            ),
          ),
        );
      },
    );
  }
}

class NearbyViews extends StatelessWidget {
  const NearbyViews({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animationController!,
          child: Transform(
            transform: Matrix4.translationValues(
              100 * (1.0 - animationController!.value),
              0.0,
              0.0,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: 300.0,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(0.0, 0.0),
                  zoom: 14.0,
                ),
                markers: _createMarkers(),
              ),
            ),
          ),
        );
      },
    );
  }


  Set<Marker> _createMarkers() {
    Set<Marker> markers = Set();

    List<LatLng> peternakanLocations = [
      LatLng(-6.21462, 106.84513),
      LatLng(-6.21422, 106.84564),
      LatLng(-6.21442, 106.84613),
    ];

    for (int i = 0; i < peternakanLocations.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('peternakan$i'),
          position: peternakanLocations[i],
          infoWindow: InfoWindow(
            title: 'Toko Peternakan',
            snippet: 'Deskripsi toko peternakan...',
          ),

          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
    return markers;
  }
}
