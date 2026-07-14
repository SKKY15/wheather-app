import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class Bottomnavbar extends StatelessWidget {

  const Bottomnavbar({super.key});


 @override
Widget build(BuildContext context) {
  return glassCard(
    child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          SvgPicture.asset("assets/ic_home.svg", width: 28),
          SvgPicture.asset("assets/ic_search.svg", width: 28),
          SvgPicture.asset("assets/ic_map.svg", width: 28),
          SvgPicture.asset("assets/ic_settings.svg", width: 28),
        ],
      ),
    ),
  );
}

Widget glassCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(24),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 30,
        sigmaY: 30,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: child,
      ),
    ),
  );
}


}