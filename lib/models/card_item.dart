import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardItem extends StatefulWidget {
  final int time;
  final bool isAm;
  final String pic;
  final int degree;

  const CardItem({
    super.key, 
    required this.time,
    required this.isAm,
    required this.pic,
    required this.degree,
    });

  @override
  State<CardItem> createState() => _CardItemState();

}

class _CardItemState extends State<CardItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child : Column(
      children: [
        Text("${widget.time.toString()}""${widget.isAm ? " AM" : " PM"}",
        
        style: TextStyle(
          color : Colors.white,
          fontSize: 24
        ),
        ),
        SizedBox(height: 8),
        SvgPicture.asset(widget.pic, width: 48, height: 48),
        SizedBox(height: 8),
        Text("${widget.degree}""°", style: TextStyle(color : Colors.white, fontSize: 24)),
        SizedBox(height: 4),
      ],
    )
    );
  }


}
