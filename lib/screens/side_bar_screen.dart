import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            UserAccountsDrawerHeader(accountName: Text('Ali Mohd' , style: TextStyle(color: Colors.black, fontFamily: "Sukar" , fontSize: 25),), 
            accountEmail: null, 
            currentAccountPicture: CircleAvatar(child: ClipOval(child: Image.asset('assets/images/user.png' , fit: BoxFit.contain, width: 120, height: 120,)),backgroundColor: Colors.white),
            decoration:BoxDecoration(color: Colors.transparent)
            ),
                      buildMenuItem(
            text:'Parking History',
            icon:Icons.history_rounded,
          ),
          buildMenuItem(
            text:'Favourites',
            icon:Icons.favorite_outline,
          ),

          SizedBox(height: 30,),

           buildMenuItem(
            text:'How it works',
            icon:Icons.info_outline,
          ),

           buildMenuItem(
            text:'Support',
            icon:Icons.support_agent,
          ),
          
           buildMenuItem(
            text:'Settings',
            icon:Icons.settings_outlined,
          ),
          SizedBox(height: size.height * 0.19),
           buildMenuItem(
            text:'Logout',
            icon:Icons.logout,
          ),
        ]),
      ),
      
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  }){
    final color =Colors.black;
return ListTile(
  leading: Icon(icon , color: color,),
  title: Text(text , style: TextStyle(color: color , fontFamily: "Sukar" , fontSize: 16),),
  onTap: (){},
);

}
