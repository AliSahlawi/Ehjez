import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjez/screens/booking_screen.dart';
import 'package:ehjez/screens/side_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ehjez/services/location.dart';
import 'package:ehjez/services/database.dart';
import 'package:ehjez/models/parking_location.dart';
import 'package:ehjez/models/user.dart' as current_user;
import 'package:provider/provider.dart';
import '../constants.dart';

// ignore_for_file: prefer_const_constructors

class MapScreen extends StatefulWidget {
  static String id = 'map_screen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final auth = FirebaseAuth.instance;

  // String currentUserId  = auth.currentUser.phoneNumber;

  Completer<GoogleMapController> _controller = Completer();

  late Widget card = Container();

  List<ParkingLocation> parkingLocations = [];
  Set<Marker> allMarkers = {};

  late BitmapDescriptor icon;

  String searchtext="";
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
final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       key: _key,
     drawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: size.height * 0.93,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  ),
                  child: Stack(children: [
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
                    card,
                    Positioned(
                      right: size.width * 0.058,
                      top: size.height - size.height * 95 / 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                                    if(_key.currentState!.isDrawerOpen){
                                      _key.currentState!.openEndDrawer();
                                    }else{
                                      _key.currentState!.openDrawer();
                                    }
                            },
                            child: Container(
                              height: size.height * 0.063,
                              width: size.width * 0.13,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white),
                              child: Icon(Icons.density_medium_rounded),
                          
                            ),
                          ),
                          SizedBox(
                            width: 195,
                          ),
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.directions_car_rounded),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'My Car',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Sukar"),
                                        ),
                                        FutureBuilder<current_user.User>(
                                            future: DatabaseService()
                                                .getUser(auth.currentUser!.uid),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.plateNum,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                );
                                              }
                                              print(snapshot.data);
                                              return Text(

                                                "8888",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              );
                                            }),
                                      ],
                                    )
                                  ]),
                            ),
                          ),




                        ],
                      ),
                    ),

                  Positioned(
                     right: size.width * 0.07,
                     top: size.height - size.height * 36 / 100,
                    child: GestureDetector(
                      onTap: () async {
                       _goToMyPosition();
                      },
                      child: Container(
                        height: size.height * 0.063,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white),
                        child: Icon(Icons.near_me_rounded ),
                                      
                                      
                      ),
                    ),
                  )


                  ]),
                )),
            Padding(
              padding:  EdgeInsets.only(left: size.width * 0.07, top: size.height * 0.009),
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => buildSheet(), 
                  ),
                child: Row(children: const [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     _goToMyPosition();

      //   },
      // ),
    );
  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    final Location location = Location();
    await location.getCurrentLocation();
    final CameraPosition _myPosition = CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 14.4746);

    controller.animateCamera(CameraUpdate.newCameraPosition(_myPosition));
    print(_myPosition);
  }

// gets all Parking locations from database and create a marker for every location
  void createMarkers() async {
    parkingLocations = await DatabaseService().getParkingLocations();
    BitmapDescriptor icon = await getIcons();
    for (var location in parkingLocations) {
      Marker newMarker = Marker(
          markerId: MarkerId(location.name),
          infoWindow: InfoWindow(title: location.description),
          icon: icon,
          position: LatLng(location.latitude, location.longitude),
          onTap: () {
            Size size = MediaQuery.of(context).size;
            setState(() {
              card = Positioned(
                right: size.width * 0.05,
                bottom: size.height - size.height * 98 / 100,
                child: GestureDetector(
                  onTap: ()  =>  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  BookingScreen(
                        parkingLocationId: location.id,
                      ),
                    ),
                  ),
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width *0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Sukar"),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Rd 2404,Muharraq',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.attach_money),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${location.pricePerHour} BD/h',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
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
              );
            });
          });

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

  Widget makeDismissible({required Widget child}) =>GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: (){} , child: child,),
  );

  Widget buildSheet() => 
  makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.7,
      builder:(_ , controller ) => Container(
        padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.width * 0.02 , horizontal:MediaQuery.of(context).size.height * 0.02 ),
        
        decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                )
              ),
        child: ListView(
          controller: controller,
          children: [    
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.02),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        cursorColor: kTextColor,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          searchtext = value;
                           buildSuggetions(searchtext);
                          },
                        onTap:() => showSuggetions(false),
 
                        
                  
                        
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey,size: 35,),
                            labelText: "Search",
                            labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                            enabledBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Colors.grey),
                             ),
                        )
                            
                            
                          
                      ),
                    ),
                  ),
                  showSuggetions(true),
        ],),
      ),
    ),
  );

  Widget showSuggetions(bool show){
    if (show == true){
    var locations = Provider.of<List<ParkingLocation>>(context);
    
     return ListView.builder(
       itemExtent: null,
       shrinkWrap: true,
       itemCount: locations.length,
       itemBuilder: (BuildContext context, int index) {  
         final suggetion = locations[index].name;
         return ListTile(
           title: Text(suggetion),
           onTap: (){
             var query = suggetion;
              
           },
           );
       }
     );
    } 
    else return Container();

  }

  Widget buildSuggetions(String query){
    var locations = Provider.of<List<ParkingLocation>>(context , listen: false);
          List<ParkingLocation> suggetions = locations.where((location){
          final result = location.name.toLowerCase();
          final input = query.toLowerCase();

          return result.contains(input);

      }).toList();


     return ListView.builder(
       itemExtent: null,
       shrinkWrap: true,
       itemCount: suggetions.length,
       itemBuilder: (BuildContext context, int index) {  
         final suggetion = suggetions[index].name;
         return ListTile(
           title: Text(suggetion),
           onTap: (){
             var query = suggetion;
              
           },
           );
       }
     );
       

  }


    
  // Widget buildSuggestions(BuildContext context , String query)  {
  //    var locations = Provider.of<List<ParkingLocation>>(context , listen:false);
  //     List<ParkingLocation> suggetions = locations.where((location){
  //         final result = location.name.toLowerCase();
  //         final input = query.toLowerCase();

  //         return result.contains(input);

  //     }).toList();


  //    return ListView.builder(
  //      itemCount: suggetions.length,
  //      itemBuilder: (BuildContext context, int index) {  
  //        final suggetion = suggetions[index].name;
  //        return ListTile(
  //          title: Text(suggetion),
  //          onTap: (){
  //            query = suggetion;
              
  //          },
  //        );

  //      },


  //    );
  // }

}







