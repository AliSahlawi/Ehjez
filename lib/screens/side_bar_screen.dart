import 'package:ehjez/screens/how_it_works_screen.dart';
import 'package:ehjez/screens/settings_screen.dart';
import 'package:ehjez/screens/support_screen.dart';
import 'package:ehjez/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ehjez/models/user.dart' as current_user;
import '../services/database.dart';
import 'favorite_screen.dart';
import 'history_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
   final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width *0.046),
          children: [
            UserAccountsDrawerHeader(
            accountName: 
            FutureBuilder<current_user.User>(
                                            future: DatabaseService()
                                                .getUser(auth.currentUser!.uid),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.name,
                                                  style: TextStyle(color: Colors.black, fontFamily: "Sukar" , fontSize: 25),
                                                );
                                              }
                                              print(snapshot.data);
                                              return Text(

                                                "Loading",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              );
                                            }),
            
            
            accountEmail: null, 
            currentAccountPicture: CircleAvatar(child: ClipOval(child: Image.asset('assets/images/user.png' , fit: BoxFit.contain, width: size.width * 0.2, height: size.height * 0.2,)),backgroundColor: Colors.white),
            decoration:BoxDecoration(color: Colors.transparent)
            ),
                      buildMenuItem(
            text:'Parking History',
            icon:Icons.history_rounded,
                          onTap: (){
              Navigator.pushNamed(context, HistoryScreen.id);
                          }

          ),
          buildMenuItem(
            text:'Favourites',
            icon:Icons.favorite_outline,
              onTap: (){
                Navigator.pushNamed(context, FavoriteScreen.id);
              }
          ),

          SizedBox(height: size.height *0.04,),

           buildMenuItem(
            text:'How it works',
            icon:Icons.info_outline,
               onTap: (){
                 Navigator.pushNamed(context, HowItWorks.id);
               }
          ),

           buildMenuItem(
            text:'Support',
            icon:Icons.support_agent,
               onTap: (){
                 Navigator.pushNamed(context, SupportScreen.id);
               }
          ),
          
           buildMenuItem(
            text:'Settings',
            icon:Icons.settings_outlined,
               onTap: (){
                 Navigator.pushNamed(context, SettingsScreen.id);
               }
          ),
          SizedBox(height: size.height * 0.17),
           buildMenuItem(
            text:'Logout',
            icon:Icons.logout,
             onTap: ()async{
              await auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
             }
          ),
        ]),
      ),
      
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  required void Function() onTap
  }){
    final color =Colors.black;
return ListTile(
  leading: Icon(icon , color: color,),
  title: Text(text , style: TextStyle(color: color , fontFamily: "Sukar" , fontSize: 16),),
  onTap:  onTap,
);

}
