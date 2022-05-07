import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class customer_review extends StatelessWidget {

   const customer_review({

    Key? key, required this.customerName,
     required this.time,
    required this.feedback,
    required this.rate

  }) : super(key: key);

  final String customerName;
   final Timestamp  time ;
  final String feedback ;
  final int rate;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding:  EdgeInsets.only(bottom: size.height*0.03, top: size.height*0.05),
        child: Column(


          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  customerName+": ",
                  style: TextStyle(color: Colors.black, fontSize: textSizeBasedOnLength(customerName.length,20,15,10) ,fontWeight: FontWeight.bold,fontFamily: "Sukar"),
                ),
                Text(
                rateDuration(time.seconds)+"  ",
                  style: TextStyle(color: Colors.black, fontSize: textSizeBasedOnLength(rateDuration(time.seconds).length, 16, 12, 10),fontFamily: "Sukar"),
                ),

              Row(
                children: [
                  for (int i =1 ;i<=5; i++)
                    if(i<=rate)
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Colors.amber,
                    )
                  else
                    Icon(
                      Icons.star_border,
                      size: 25,
                      color: Colors.amber,
                    )



                ],




              )
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: size.width*0.1,top: size.height*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Text(
                    feedback,
                    style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Sukar"),
                  )
                ],
              ),
            )
          ],
        ),
      );

  }


 String rateDuration (int dateFromDB){
    var duration = Timestamp.fromDate(DateTime.now()).seconds - dateFromDB ;

    if(duration<60) { // if the duration in seconds
      return "$duration Seconds ago";
    }
    else if (duration>=60 && duration<3600){// if the duration in minutes

      if(duration ~/ 60 ==1 )
        return "${duration ~/60} Minute ago";
      else
        return "${duration ~/60} Minutes ago";


    }
    else if (duration>=3600 && duration<86400){// if the duration in hours

      if(duration ~/3600 ==1 )
        return "${duration ~/3600} Hour ago";
      else
      return "${duration ~/3600} Hours ago";

    }

    else if (duration>=86400 && duration<604800){// if the duration in days

      if(duration ~/86400==1)
      return "${duration ~/86400} Day ago";
      else
        return "${duration ~/86400} Days ago";
    }

    else if(duration>=604800 && duration< 2.628e+6){ //if the duration in weeks
      if(duration ~/604800 ==1)
      return "${duration ~/604800} Week ago";
      else
        return "${duration ~/604800} Weeks ago";

    }

    else if (duration>=2.628e+6 && duration < 3.154e+7 ){//if the duration in months
      if(duration ~/2.628e+6==1)
      return "${duration ~/2.628e+6} Month ago";
      else
        return "${duration ~/2.628e+6} Months ago";
    }

    else {
      if(duration ~/3.154e+7==1)
      return "${duration ~/3.154e+7} Year ago";
      else
        return "${duration ~/3.154e+7} Years ago";
    }
 }

 double textSizeBasedOnLength(int length,double normalSize, double smallSize,int maxlenght){
    if(length>maxlenght)
      return smallSize;
    else
      return normalSize;
 }

}


