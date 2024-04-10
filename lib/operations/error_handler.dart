
import 'package:flutter/foundation.dart';

class AppLogger {
  static log(message) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print(message);
      }
    }
  }
}