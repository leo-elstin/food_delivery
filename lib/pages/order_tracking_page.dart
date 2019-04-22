import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlacePolylineBodyState();
  }
}

class PlacePolylineBodyState extends State<OrderTrackingPage> {
  PlacePolylineBodyState();

  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 1;
  PolylineId selectedPolyline;

  // Values when toggling polyline color
  int colorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  // Values when toggling polyline width
  int widthsIndex = 0;
  List<int> widths = <int>[10, 20, 5];

  int jointTypesIndex = 0;
  List<JointType> jointTypes = <JointType>[
    JointType.mitered,
    JointType.bevel,
    JointType.round
  ];

  // Values when toggling polyline end cap type
  int endCapsIndex = 0;
  List<Cap> endCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline start cap type
  int startCapsIndex = 0;
  List<Cap> startCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline pattern
  int patternsIndex = 0;
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[],
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)],
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
  ];

  void _onMapCreated(GoogleMapController controller) {
    // this._controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPolylineTapped(PolylineId polylineId) {
    setState(() {
      selectedPolyline = polylineId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool iOSorNotSelected = Platform.isIOS || (selectedPolyline == null);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addGymPoly();
        },
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        onTap: (value) {
          print(value);
        },
        initialCameraPosition: const CameraPosition(
          target:  LatLng(8.2637465, 77.2866609),
          zoom: 16.0,
        ),
        polylines: Set<Polyline>.of(polylines.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          //_initCameraPosition();
        },
      ),
    );
  }

  void _addGymPoly() {
    _gymCameraPosition();
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.black,
      width: 5,
      points: _createGymPoints(),
      onTap: () {
        _onPolylineTapped(polylineId);
      },
    );

    setState(() {
      polylines[polylineId] = polyline;
    });
  }

  Future<void> _gymCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(8.2637465, 77.2866609),
      zoom: 18.5,
    )));
  }

  List<LatLng> _createGymPoints() {
    final List<LatLng> points = <LatLng>[];
    points.add(_createLatLng(8.2637465, 77.2866609));
    points.add(_createLatLng(8.2630653, 77.28699619999999));
    points.add(_createLatLng(8.2673574, 77.2891867));
    points.add(_createLatLng(8.2451474, 77.3161195));
    // points.add(_createLatLng(-8.911857, 13.203656));
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
