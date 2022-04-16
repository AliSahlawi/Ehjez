import 'package:flutter/material.dart';

class customer_review extends StatelessWidget {

   const customer_review({

    Key? key, required this.customerName,
    // required this.time,
    required this.feedback,
    required this.rate

  }) : super(key: key);

  final String customerName;
  // final String  time ;
  final String feedback ;
  final int rate;



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 40),
      child: Column(


        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                customerName+": ",
                style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
              ),
              // Text(
              //   time+"  ",
              //   style: TextStyle(color: Colors.black, fontSize: 16),
              // ),

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
            padding: const EdgeInsets.only(left: 80,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text(
                  feedback,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


