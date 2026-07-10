import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key});
  @override
  State<CardItem> createState() => _CardItemState();

}

class _CardItemState extends State<CardItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("12 PM",
        style: TextStyle(
          color : Colors.white
        ),
        ),
        SizedBox(height: 8),
        SvgPicture.asset("assets/cloudy.svg", width: 24, height: 24),
        SizedBox(height: 8),
        Text("20°", style: TextStyle(color : Colors.white)),
        SizedBox(height: 4),
        Text("12 PM", style: TextStyle(color : const Color.fromARGB(46, 255, 255, 255))),
      ],
    );
  }


}
