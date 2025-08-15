import 'package:flutter/widgets.dart';

// Retourne la hauteur totale de l'écran actuel
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Retourne la largeur totale de l'écran actuel
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// Retourne une hauteur proportionnelle
double hauteur(BuildContext context, double value) {
  // screenHeight(context) → hauteur actuelle de l'écran
  // myHeight → hauteur de référence (ex: maquette)
  // value → la hauteur qu'on veut sur la maquette
  return screenHeight(context) * value / myHeight;
}

// Retourne une largeur proportionnelle
double largeur(BuildContext context, double value) {
  // Même logique que hauteur()
  return screenWidth(context) * value / myWidth;
}

// Dimensions de référence sur lesquelles le designer a travaillé
const double myHeight = 720.0;
const double myWidth = 360.0;