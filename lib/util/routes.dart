import 'package:flutter/material.dart';
import 'package:health_congress/screens/home/homepage.dart';

Route? routes(RouteSettings settings) {
  if (settings.name == 'HomePage') {
    return MaterialPageRoute(
      builder: (context) {
        return HomePage();
      },
    );
  }
  //  else if (settings.name == 'Loginscreen') {
  //   return MaterialPageRoute(
  //     builder: (context) {
  //       return Loginscreen();
  //     },
  //   );
  // }

  return null;
}
