import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class SupportScreen extends StatelessWidget {
  static String id = 'support_screen';
  const SupportScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 15, 25),
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
                            'Support',
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Sukar", fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.08,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                    child: Row(
                      children: [
                        Text('Contact Us!',style:TextStyle(
                            color: kTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sukar") ,),
                          
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 0, 10),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextButton.icon(     
                         onPressed: () => Utils.openEmail(
                           toEmail:'seniorprojectitse498@gmail.com' ,
                           ),
                         icon: Icon(
                           Icons.mail,
                           color: Colors.amberAccent,
                           size: 30.0,
                         ),
                         label: Text('Email',style: TextStyle(color: Colors.black , fontSize: 16),),
                         ),
                         SizedBox(height: size.height * 0.03,),
                         TextButton.icon(     
                         onPressed: () => Utils.openPhoneCall(phoneNum:'+97339210225'),
                         icon: Icon(
                           Icons.phone,
                           color: Colors.amberAccent,
                           size: 30.0,
                         ),
                         label: Text('Call us',style: TextStyle(color: Colors.black,fontSize: 16),),
                         ),
                         SizedBox(height: size.height * 0.03,),
                         TextButton.icon(     
                         onPressed: () => Utils.openSMS(phoneNum:'+97339210225'),
                         icon: Icon(
                           Icons.sms,
                           color: Colors.amberAccent,
                           size: 30.0,
                         ),
                         label: Text('Sent SMS' ,style: TextStyle(color: Colors.black,fontSize: 16), ),
                         ),
                         
                        ],),
                    ],
                  ),
                )  

            ]),
          ),

      ),
    );
  }
}

class Utils{
  static Future launchUrl(String url)async{
    try {
      await launch(
        url,
     );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }

  }

  static Future openEmail({required String toEmail})async {
    final url='mailto:$toEmail';
    await launchUrl(url);
  }

  static Future openPhoneCall({required String phoneNum}) async {
    final url = 'tel:$phoneNum';
    await launchUrl(url);
  }

  static Future openSMS({required String phoneNum})async {
    final url = 'sms:$phoneNum';
    await launchUrl(url);
  }
}