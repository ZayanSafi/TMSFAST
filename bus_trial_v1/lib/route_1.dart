import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:google_directions_api/google_directions_api.dart' as directions;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];
  String? _currentAddress;
  String? _destinationAddress;
  String? _eta;
  late FirebaseMessaging messaging;
 
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(33.6799, 73.0125),
    zoom: 11.5,
  );
  late GoogleMapController _googleMapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  poly.PolylinePoints polylinePoints = poly.PolylinePoints();

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    _getFcmToken();
    _getPolyline();
  }

  void _getFcmToken() async {
    final fcmToken = await messaging.getToken();
    await messaging.subscribeToTopic("bus"); //dont need
    print(fcmToken);
  }

  Future<void> sendFCMMessage(String token, String title, String mbody) async {
      final postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAV5wAYEk:APA91bGw9Cb2NaX-54fEno2KisAiEelg9o2PDcESlh6u3tk49qD1OGekrhap7MExQa0YMsS0Y7CPvBXJF5Ip_FsvJUUAOaWKmphHxYxQWySrNX8A3LF_y_cXD9eHa5_CsNXOgjqMY_Pu',
      };
      final body = <String, dynamic>{
        'notification': {'title': title, 'body': mbody},
        'priority': 'high',
        'to': token,
      };
      final jsonEncodedBody = json.encode(body);
      final response = await http.post(
        postUrl,
        headers: headers,
        body: jsonEncodedBody,
      );
      if (response.statusCode == 200) {
        print('FCM message sent');
      } else {
        print('Failed to send FCM message');
      }
  }


  // Get polyline for the route between source and destination
  void _getPolyline() async {
    final ref = FirebaseDatabase.instance.ref();
    directions.DirectionsService.init('AIzaSyAJbdPy3UF-DvZDatNrAU3CevDVX6Hdye8');
    final _directionsApi = directions.DirectionsService();

    print("before");
    final snapshot = await ref.child('Bus').get();
    print("hi");
    if (snapshot.exists) {
        a = snapshot.value;
        List all = List.from(a as List);
        for (var i = 0; i < all.length; i++) {
          try {
            Map<String, dynamic> _post = Map<String, dynamic>.from(all[i] as Map);
            array.add(_post);
            } catch (e) {
            print('null error');
          }
        }
        setState(() {    
        });
    print(array[0]['Long']);
    print("End");
    print(array[0]['Lat']);
    }
    // LatLng _sourceCoordinates = LatLng(33.6528, 73.0177);
    LatLng _sourceCoordinates = LatLng(array[0]['Lat'],array[0]['Long']);
    LatLng _destinationCoordinates = LatLng(33.6882, 73.0351);

    _markers.add(Marker(
      markerId: MarkerId('source'),
      position: _sourceCoordinates,
      infoWindow: InfoWindow(
        title: 'Source',
        snippet: 'This is the source location',
      ),  
    ));
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: _destinationCoordinates,
      infoWindow: InfoWindow(
        title: 'Destination',
        snippet: 'This is the destination location',
      ),
    ));

    poly.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAJbdPy3UF-DvZDatNrAU3CevDVX6Hdye8',
      poly.PointLatLng(_sourceCoordinates.latitude, _sourceCoordinates.longitude),
      poly.PointLatLng(
          _destinationCoordinates.latitude, _destinationCoordinates.longitude),
      travelMode: poly.TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((poly.PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    else{
      print("empty poly");
    }
    
    await placemarkFromCoordinates(_sourceCoordinates.latitude, _sourceCoordinates.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });

    await placemarkFromCoordinates(_destinationCoordinates.latitude, _destinationCoordinates.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _destinationAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });



    final source = _currentAddress;
    final destination = _destinationAddress;


    // Get the route between the source and destination
    final request = directions.DirectionsRequest(
      origin: source,
      destination: destination,
      travelMode: directions.TravelMode.driving,
    );

    print(source);
    print(destination);

    _directionsApi.route(request,
      (directions.DirectionsResult response, directions.DirectionsStatus? status) {
    if (status == directions.DirectionsStatus.ok) {
      print("Directions request successful");
      // Extract the ETA from the response object
      final duration = response.routes?.first.legs?.first.duration!.text;
      print("ETA: $duration");
      setState(() {
        _eta = 'ETA: $duration';
      }); 
      // Check if ETA is 5 minutes or less
      if (duration != null && duration == '13 mins') {
        print("Sending notification...");
        sendFCMMessage(
        'f8ii-1grTFOr6usB2PxWWO:APA91bHBV8d1jd6_naS_zDA2KEJpM6HepbbmET3JhQXAHP-1TMS7Og6PrTmN0cbWphtTYOJAXe7ohYHyf-RXm4eF6G7cAPVosw36U1P2n9C-I1IlySNws52d7xf5uzqtYKnhTpI2d-OH',
       "Bus ETA", "The bus will arrive in 17 minutes."); 
      }
    } else {
      print("Dir FAIL");
      setState(() {
        _eta = 'Unable to calculate ETA';
      });
    }
    });



    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('polyline'),
        color: Colors.blue,
        points: polylineCoordinates,
        width: 5,
      ));
    });
    
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          markers: _markers,
          polylines: _polylines,
          onMapCreated: (controller) => _googleMapController = controller,
        ),
        Positioned(
            bottom: 200,
            left: 5,
            right: 16,
            child: Text(
              _eta ?? 'Calculating ETA...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}