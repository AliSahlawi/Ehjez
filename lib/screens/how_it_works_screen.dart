import 'package:flutter/material.dart';

import '../constants.dart';

class HowItWorks extends StatelessWidget {
  static String id = 'howitworks_screen';
  const HowItWorks({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding:  const EdgeInsets.fromLTRB(10, 25, 15, 25),
          child: ListView(
            physics: BouncingScrollPhysics(),
            
            children: [ 
              Column(
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
                               width: size.width * 0.15,
                             ),
                            Text(
                              'How it works',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.08,),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("1" , style: TextStyle(color: Colors.amberAccent , fontSize: 45 , fontWeight: FontWeight.bold ,),),
                                SizedBox(width: size.width * 0.02),
                                RichText(
                                  text:TextSpan(
                                    text: "Find a parking location!\n",
                                    style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(text: 'You can search for a car park\nin the map or use the search bar' ,
                                      style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar"),
                                       )
                                    ]
                                  ) 
                                )
                              ],
                            ),
                            SizedBox(height: size.height*0.01,),
                            CircleAvatar(
                                backgroundImage: AssetImage('assets/images/hiw--1.png'),
                                radius: size.width * 0.2,
                              ),
                            SizedBox(height: size.height*0.02,),
              
                              Padding(
                                padding:  EdgeInsets.only(left:size.width * 0.07),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("2" , style: TextStyle(color: Colors.amberAccent , fontSize: 45 , fontWeight: FontWeight.bold ,),),
                                  SizedBox(width: size.width * 0.02),
                                  RichText(
                                    text:TextSpan(
                                      text: "Select the time!\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: 'You can select the \narrival and leaving times' ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar"),
                                         )
                                      ]
                                    ) 
                                  )
                                ],
                            ),
                              ),
                            SizedBox(height: size.height*0.01,),
                            CircleAvatar(
                                backgroundImage: AssetImage('assets/images/hiw--2.png'),
                                radius: size.width * 0.2,
                              ),
          
                              SizedBox(height: size.height*0.02,),
              
                              Padding(
                                padding:  EdgeInsets.only(left:size.width * 0.07),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("3 " , style: TextStyle(color: Colors.amberAccent , fontSize: 45 , fontWeight: FontWeight.bold ,),),
                                  SizedBox(width: size.width * 0.02),
                                  RichText(
                                    text:TextSpan(
                                      text: "Book your park!\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Pay through a dircect and safe\npayement gateway and book you park' ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar"),
                                         )
                                      ]
                                    ) 
                                  )
                                ],
                            ),
                              ),
                            SizedBox(height: size.height*0.01,),
                            CircleAvatar(
                                backgroundImage: AssetImage('assets/images/hiw--3.png'),
                                radius: size.width * 0.2,
                              ),


                              SizedBox(height: size.height*0.02,),
                              Padding(
                                padding:  EdgeInsets.only(left:size.width * 0.07),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("4 " , style: TextStyle(color: Colors.amberAccent , fontSize: 45 , fontWeight: FontWeight.bold ,),),
                                  SizedBox(width: size.width * 0.02),
                                  RichText(
                                    text:TextSpan(
                                      text: "Upon arrival!\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Just scan your reservation barcode\nthere is no need to print anything out' ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar"),
                                         )
                                      ]
                                    ) 
                                  )
                                ],
                            ),
                              ),
                            SizedBox(height: size.height*0.01,),
                            CircleAvatar(
                                backgroundImage: AssetImage('assets/images/hiw--4.png'),
                                radius: size.width * 0.2,
                              )
                          ],
                        ),
              ],
            ),
            ]
          ),
        ),
      ),
      
    );
  }
}