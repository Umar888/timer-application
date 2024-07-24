import 'package:flutter/material.dart';

class AppColors {
  static const Color groupBackgroundColor = Color(0xFFF7F8FA);
  static const Color startColorOf3dButton = Color(0xFF4CA1FF);
  static const Color endColorOf3dButton = Color(0xFF3256D2);
  static const Color todoColor = Color(0xFFF69D0D);
  static const Color primaryColor = Color(0xFF5046E5);
  static const Color inProgressColor = Color(0xFF5046E5);
  static const Color doneColor = Color(0xFF22C55D);
  static const Color travelTagColor = Color(0xFFD5FFD3);
  static const Color workTagColor = Color(0xFFD5FFEF);
  static const Color funTagColor = Color(0xFFF4FFDB);
  static const Color healthTagColor = Color(0xFFFFC1C1);
  static const Color educationTagColor = Color(0xFFE3FFC9);
  static const Color familyTagColor = Color(0xFFFFE7BA);
  static const Color financeTagColor = Color(0xFFE0CFFF);
  static const Color shoppingTagColor = Color(0xFFFFE0E6);
  static const Color exerciseTagColor = Color(0xFFC1FFD7);
  static const Color leisureTagColor = Color(0xFFE1D4FF);
  static const Color errandsTagColor = Color(0xFFFFE7D4);
  static const Color cookingTagColor = Color(0xFFFFDAB9);
  static const Color cleaningTagColor = Color(0xFFF0FFF0);
  static const Color socialTagColor = Color(0xFFCCE5FF);
  static const Color personalDevelopmentTagColor = Color(0xFFFFC6E0);
  static const Color projectTagColor = Color(0xFFFFFACD);
  static const Color hobbyTagColor = Color(0xFFE1FFDF);
  static const Color volunteerTagColor = Color(0xFFFFDEB5);
  static const Color technologyTagColor = Color(0xFFB0E0E6);
  static const Color otherTagColor = Color(0xFFFDE6FE);

  static const double shadeIntensity = 0.9;

  static Color generateDarkShade(Color color) {
    return Color.fromARGB(
      color.alpha,
      (color.red * shadeIntensity).toInt(),
      (color.green * shadeIntensity).toInt(),
      (color.blue * shadeIntensity).toInt(),
    );
  }
}

