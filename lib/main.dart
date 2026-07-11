import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './models/card_item.dart';
import 'dart:math';
import './utils/weather_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration : BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4DA8FF),
                Color(0xFF1E5AA8), // mid blue
                Color(0xFF071A3D),
              ])
          ),
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children :  [
                  SizedBox(height: 16),
                  Text(
                    "Oslo, Norway",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color : Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    "Wed, Oct 19 | 11:30AM",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color : Color.fromRGBO(232, 232, 232, 1),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  glassCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "19°",
                              style: TextStyle(
                                fontSize: 100,
                                color : Colors.white
                              ),
                            ),
                            Text(
                              "Cloudy",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              "14° / 20°",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromRGBO(232, 232, 232, 1),
                              ),
                            ),
                          ],
                        ),
                        
                        SvgPicture.asset("assets/rain_alt.svg",
                        width: 200, height: 200),
                        
                        
                      ],
                    )
                    ),
                    
                    SizedBox(height: 16),


                    glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text("Hourly forecast",
                              style: TextStyle(
                                color : Colors.white,
                                fontSize: 24,
                                
                              ),
                            ),
                            SizedBox(height: 12),
                            
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child : Row(
                                children: List.generate(24, (index) {
                                  final random = Random();
                                  int number = random.nextInt(41);
                                    return CardItem(
                                      time : index > 12 ? index - 12 : index,
                                      isAm : index > 11 ? false : true,
                                      pic : "assets/cloudy.svg",
                                      degree : number,
                                    );

                                }),
                              ),
                              
                            )
                        ],
                      )
                    )
                ]
              ),
          ),
        )
      ),
    );
  }
}
Widget glassCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(16),
    child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.5,
            ),
          ),
          child: child
        ),
      
      ),
  );
}