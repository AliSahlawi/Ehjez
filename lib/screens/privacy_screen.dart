import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class PrivacyScreen extends StatelessWidget {
  static String id = 'privacyscreen_screen';
  
  const PrivacyScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: kTextColor,
                              ),
                            ),
        elevation: 0,
        title: Text("Privacy" , style: TextStyle(color: Colors.black, fontFamily: "Sukar", fontSize: 30),),                    
        backgroundColor: Colors.white,
        centerTitle:true, 
      ),
      body: Container(
        height: size.height,
        width: size.height,

        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal : size.width *0.03  , vertical: size.height*0.02),
              child: Column(
                children: [
                  RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Privacy Policy\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 40 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"We respect your privacy and are committed to protecting it through our compliance with this privacy policy ('Policy'). This Policy describes the types of information we may collect from you or that you may provide ('Personal Information') in the “Ehjez” mobile application (“Mobile Application” or “Service”) and any of its related products and services (collectively, “Services”), and our practices for collecting, using, maintaining, protecting, and disclosing that Personal Information. It also describes the choices available to you regarding our use of your Personal Information and how you can access and update it.This Policy is a legally binding agreement between you (“User”, “you” or “your”) and this Mobile Application developer (“Operator”, “we”, “us” or “our”). If you are entering into this agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such entity to this agreement, in which case the terms “User”, “you” or “your” shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this agreement, you must not accept this agreement and may not access and use the Mobile Application and Services. By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Policy. This Policy does not apply to the practices of companies that we do not own or control, or to individuals that we do not employ or manage. This privacy policy was created with the help of the privacy policy generator.", 
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Collection of personal information\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"You can access and use the Mobile Application and Services without telling us who you are or revealing any information by which someone could identify you as a specific, identifiable individual. If, however, you wish to use some of the features offered in the Mobile Application, you may be asked to provide certain Personal Information (for example, your name and e-mail address).We receive and store any information you knowingly provide to us when you create an account, or fill any forms in the Mobile Application. When required, this information may include the following: 1-Account details (such as user name, unique user ID, password, etc) 2-Contact information (such as email address, phone number, etc)3-Geolocation data of your device (such as latitude and longitude)4-You can choose not to provide us with your Personal Information, but then you may not be able to take advantage of some of the features in the Mobile Application. Users who are uncertain about what information is mandatory are welcome to contact us.",

                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                                  RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Use and processing of collected information\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"You can access and use the Mobile Application and Services without telling us who you are or revealing any information by which someone could identify you as a specific, identifiable individual. If, however, you wish to use some of the features offered in the Mobile Application, you may be asked to provide certain Personal Information (for example, your name and e-mail address).We receive and store any information you knowingly provide to us when you create an account, or fill any forms in the Mobile Application. When required, this information may include the following: 1-Account details (such as user name, unique user ID, password, etc) 2-Contact information (such as email address, phone number, etc)3-Geolocation data of your device (such as latitude and longitude)4-You can choose not to provide us with your Personal Information, but then you may not be able to take advantage of some of the features in the Mobile Application. Users who are uncertain about what information is mandatory are welcome to contact us.",

                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          SizedBox(height: size.height * 0.02,),
                                  RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Contacting us\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"If you have any questions, concerns, or complaints regarding this Policy, the information we hold about you, or if you wish to exercise your rights, we encourage you to contact us using the details below:\nseniorprojectitse498@gmail.com",
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          Row(
                            children: [
                              Text("You can view the policy in full details by", style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                   ),
                            TextButton(     
                         onPressed: () => Utils.openLink(
                           url:'https://app.websitepolicies.com/policies/view/uvk6zoal' ,
                           ), child: Text("Clicking here" , style: TextStyle(color: Colors.amberAccent , fontSize: 16 ),),
                            )
                         
                            ],
                          )
                  
                  
                          
                
                ],
              ),
            )
          ],
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

  static Future openLink({required String url})async {
    await launchUrl(url);
  }


}