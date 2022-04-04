import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ehjez/services/location.dart';



class MapScreen extends StatefulWidget {
  static String id = 'map_screen';
  
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();






  static final Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_KGooglePlexMarker'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  static final CameraPosition _kGooglePlex = CameraPosition(

    target: LatLng(26.1864, 50.5505),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              height: size.height - 90,
            
            child: ClipRRect(
              borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(45),
              bottomLeft: Radius.circular(45),
            ),
              child: GoogleMap(
                    markers: {_kGooglePlexMarker},
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
            )
            ),
        
    
             Padding(
               padding: const EdgeInsets.only(left: 25 , top: 25),
               child: Row(
                 children: [
                  Icon(Icons.search , color: Colors.grey, size: 35,),
                  SizedBox(width: 10,),
                  Text('Search' , style: TextStyle(color: Colors.grey , fontSize: 20),)
    
    
                ]),
             ),
    
            
          ],
        ),
    
    
      
      ),
    );
  }

  Future<void> _goToMyPosition() async {


    final GoogleMapController controller = await _controller.future;
    final Location location = Location();
    await location.getCurrentLocation();
    final CameraPosition _myPosition = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 10.4746
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(_myPosition));
    print(_myPosition);


  }


}




