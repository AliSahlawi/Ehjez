import 'package:flutter/material.dart';

import '../constants.dart';

class TermsOfUse extends StatelessWidget {
  static String id = 'termsofuse_screen';
  
  const TermsOfUse({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
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
        title: Text("Terms of Use" , style: TextStyle(color: Colors.black, fontFamily: "Sukar", fontSize: 30),),                    
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
                                      text: "Changes to the Terms\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text: "We reserve the right to update these terms, as well as any additional terms that apply to a Service, to reflect changes in the law or changes to our Services. You should review the terms on a frequent basis. Any changes to these terms will be announced on this page. Modified additional terms will be announced in the appropriate Service. Changes will not be applied retrospectively and will take effect fourteen days after they are posted. Changes that address new functions for a Service or changes made for legal reasons, on the other hand, will take effect immediately. If you do not agree to the updated terms for a Service, you should stop using it immediately." ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Using our Services\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text: "Using Ehjez may include downloading software to your phone, tablet, or other device. You agree that we may automatically update that software, and these terms will apply to any updates.We are a technology company. We do not own, operate, or maintain any parking facility, and we do not provide parking enforcement services. Parking facilities are operated by third-parties. Parking restrictions (i.e. no parking signs) take precedence over any information that you receive from us. All applicable parking rules and regulations apply to you, and your use of the Services does not excuse you from following the rules." ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Your Ehjez Account\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"You may need a Ehjez account in order to use some of our Services. When you create your Ehjez account, you must provide us with accurate and complete information. " ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Network Access and Devices\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text:"To enjoy any of our services, you may require an Ehjez account. You can either create your own Ehjez account or have one assigned to you by an administrator, such as your boss. You must submit accurate and complete information while creating your Ehjez account. Different or extra terms may apply if you use an Ehjez account that was assigned to you by an administrator, and your administrator may be able to access or disable your account.",
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          SizedBox(height: size.height * 0.02,),
                          RichText(
                  textAlign: TextAlign.justify,
                                    text:TextSpan(
                                      text: "Payment\n",
                                      style: TextStyle(color: kTextColor ,fontFamily: "Sukar", fontSize: 30 , fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                        text: "You understand that use of the Services may result in charges to you for the services you receive ('Charges'). We will receive and/or enable your payment of the applicable Charges for services obtained through your use of the Services. Charges will be inclusive of applicable taxes where required by law. All payments will be done through a third party service." ,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Sukar" ),
                                         )
                                      ]
                                    ) 
                          ),
                          
                          
                         
               
                ],
              ),
            )
          ],
        ),
      ),
      
    );
  }
}