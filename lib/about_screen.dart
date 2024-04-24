import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFBCE2E8),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFBCE2E8),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.business_sharp,
                    size: 75,
                  ),
                  SizedBox(height: 70,),
                  const Text(
                    '     Created by Faris Allaf, this ice cream shop was developed to provide a minimal, yet joyful experience'
                      ' to customers not just through our sundaes, but also through the process of purchasing your sundae'
                        '\n \n'
                        '     If you have any new flavor suggestions or topping requests, please let us know at faris.allaf@gmail.com!'
                        '\n \n'
                        'Thank you for eating at the Hackers Galore Parlor!'
                    ,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '😊',
                    style: TextStyle(fontSize: 75),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
