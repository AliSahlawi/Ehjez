import 'package:flutter/material.dart';

import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  static String id = 'settings_screen';
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding:  const EdgeInsets.fromLTRB(10, 25, 15, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.08,),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Con(context: context, text: "Account", icon: Icons.person)),
                              GestureDetector(
                                onTap: (){},
                                child: Con(context: context, text: "Terms of use ", icon: Icons.question_mark_rounded))
                            ],
                          ),
                          SizedBox(height: size.height * 0.05,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                        
                              GestureDetector(
                                onTap: (){},
                                child: Con(context: context, text: "Privacy", icon: Icons.privacy_tip)),
                              Container( height: MediaQuery.of(context).size.height*0.15,
                                          width: MediaQuery.of(context).size.height*0.15,),
                            ],
                          ),
                        ],
                      )

                



          ]),
        ),
      
      
      
      ),
    );
  }


  Widget Con({
  required BuildContext context,
  required String text,
  required IconData icon,
  }){
    
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      width: MediaQuery.of(context).size.height*0.15,  
      decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
       width: 1.8, 
      color: kTextColor,
       ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Padding(
      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(icon , color: kTextColor, size: 60,),
            Text(text , style: TextStyle(color: kTextColor , fontFamily: "Sukar" , fontSize: 20),)
        ]),
    ),
  );

  }
}