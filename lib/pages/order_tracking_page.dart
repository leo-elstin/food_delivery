import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
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
    fetchData();
  }

  void fetchData() {
    MarkerId markerId = MarkerId("value");

    final Marker marker = Marker(
      markerId: markerId,
      // icon: _setM,
      position: LatLng(8.266300319044133, 77.29164976626635),
      // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    setState(() {
      markers[markerId] = marker;
    });

    _getAssetIcon(context).then(
      (BitmapDescriptor icon) {
        _setMarkerIcon(icon);
      },
    );
    List<LatLng> latlng = [];

    Firestore.instance
        .collection('location_test')
        .snapshots()
        .listen((onData) => onData.documents.forEach((f) {
              GeoPoint geo = f.data['lat_lng'];
              var data = LatLng(geo.latitude, geo.longitude);
              latlng.add(data);
              _addPolyLines(latlng);
            }));
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (MarkerId("value") == null) {
          return;
        }

        final Marker marker = markers[MarkerId("value")];
        setState(() {
          markers[MarkerId("value")] = marker.copyWith(
            positionParam: LatLng(8.264000988351677, 77.29503806680441),
            rotationParam: 30
          );
        });
        _newCamPosition(LatLng(8.263287297268167, 77.29503806680441));
      }),
      body: GoogleMap(
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
        onTap: (value) {
          // Firestore.instance.collection('location_test').document()
          // .setData({'lat_lng' : GeoPoint(value.latitude, value.longitude)});
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(8.2637465, 77.2866609),
          zoom: 16.0,
        ),
        polylines: Set<Polyline>.of(polylines.values),
        onMapCreated: (GoogleMapController controller) {
          fetchData();
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
      color: Colors.blue,
      width: 15,
      points: _createGymPoints(),
      onTap: () {
        _onPolylineTapped(polylineId);
      },
    );

    setState(() {
      polylines[polylineId] = polyline;
    });
  }

  void _addPolyLines(List<LatLng> list) {
    _gymCameraPosition();
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.blue,
      width: 10,
      points: list,
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
      target: LatLng(8.266300319044133, 77.29164976626635),
      zoom: 15,
    )));
  }

  Future<void> _newCamPosition(LatLng latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latlng,
      zoom: 15,
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

  void _setMarkerIcon(BitmapDescriptor assetIcon) {
    if (MarkerId("value") == null) {
      return;
    }

    final Marker marker = markers[MarkerId("value")];
    setState(() {
      markers[MarkerId("value")] = marker.copyWith(
        iconParam: assetIcon,
        rotationParam: 30,
        anchorParam: Offset(.1, .1)
      );
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config = createLocalImageConfiguration(context);

    const AssetImage('assets/red_square.png')
        .resolve(config)
        .addListener((ImageInfo image, bool sync) async {
      final ByteData bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    });

    return await bitmapIcon.future;
  }
}
