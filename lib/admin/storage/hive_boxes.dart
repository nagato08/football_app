import 'package:hive/hive.dart';

class HiveBoxes {
  static const String settingsBox = 'settings';

  static Future<void> initHive() async {
    await Hive.openBox(settingsBox);
  }
}