import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ehjez/services/location.dart';
import 'package:ehjez/services/database.dart';

// ignore_for_file: prefer_const_constructors


class MapScreen extends StatefulWidget {
  static String id = 'map_screen';
  
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();


  var parkingLocations =  [];
  Set<Marker> allMarkers = {} ;
  late BitmapDescriptor icon ;

  @override
  void initState() {

    super.initState();
    // getIcons();
    createMarkers();

  }




  static final CameraPosition _startingPosition = CameraPosition(

    target: LatLng(26.1864, 50.5505),
    zoom: 14.4746,
  );


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
              child: Stack(
                children: [
                 GoogleMap(
                      markers: allMarkers,
                      mapType: MapType.normal,
                      initialCameraPosition: _startingPosition,
                      onMapCreated: (GoogleMapController controller) {
                        // getIcons();
                        createMarkers();
              
                        _controller.complete(controller);
              
                      },
                    ),

                    Positioned(
                      right: size.width - 372,
                      bottom: size.height - 800,
                      child: Container(
                        height: 150,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                               padding: const EdgeInsets.all(15),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('Bahrain Airport' , style: TextStyle(color: Colors.black , fontSize: 25 , fontWeight: FontWeight.bold , fontFamily: "Sukar"),),
                                   SizedBox(height: 3,),
                                   Text('Rd 2404,Muharraq' , style: TextStyle(color: Colors.grey , fontSize: 16),),
                                   SizedBox(height: 25,),
                                   Row(
                                     children: [
                                       Icon(Icons.attach_money ),
                                       SizedBox(width: 4,),
                                       Text('2 BD/h' , style: TextStyle(color: Colors.black , fontSize: 16),)
                                     ],
                                   )
                                 ],
                               ),
                             ),
                    
                    
                    
                              Image(
                          image: AssetImage("assets/images/locate_park.png"),
                          height: 150,
                          width: 150) 
                          ],
                        ),
                      ),
                    ),



                    Positioned(
                      right: size.width-372,
                      top: size.height -780,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Container(
                              height: 52,
                              width: 50,
                             decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white
                          ),

                          child: Icon(Icons.density_medium_rounded),
                          ),

                          SizedBox(width: 195,),
                          
                          Container(
                              height: 52,
                              width: 100,
                             decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white
                          ),
                    
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.directions_car_rounded),
                                SizedBox(width: 3,),
                                Column(children: [
                                  Text('My Car' , style: TextStyle(color: Colors.black , fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: "Sukar"),),
                                   Text('105483' , style: TextStyle(color: Colors.grey , fontSize: 13),),
                                ],)
                    
                    
                            ]),
                          ),
                    
                          ),
                          
                        ],
                      ),
                    )
                ]
              ),
            )
            ),
        
    
             Padding(
               padding: const EdgeInsets.only(left: 25 , top: 25),
               child: Row(
                 children: const [
                  Icon(Icons.search , color: Colors.grey, size: 35,),
                  SizedBox(width: 10,),
                  Text('Search' , style: TextStyle(color: Colors.grey , fontSize: 20),)
    
    
                ]),
             ),
    
            
          ],
        ),
    
    
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _goToMyPosition();
        },
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



// gets all Parking locations from database and create a marker for every location
  void createMarkers() async{
     parkingLocations = await  DatabaseService().getParkingLocations();
     BitmapDescriptor icon = await getIcons();
    for (var location in parkingLocations)
{
  Marker newMarker = Marker(
      markerId: MarkerId(location['Name']),
      infoWindow: InfoWindow(title: location['Description']),
      icon: icon,
      position: LatLng(location['Latitude'], location['Longitude']),
  );

  setState(() {
    allMarkers.add(newMarker);
  });

}
}
  getIcons() async {
     var iconImage = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        "assets/images/icons8-parking-100-yellow.jpg");
        return iconImage;
  }




}




