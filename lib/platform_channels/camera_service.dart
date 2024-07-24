import 'dart:developer' as developer;

import 'package:flutter/services.dart';

class CameraService {
  static const MethodChannel _channel = MethodChannel('com.camera');

  static Future<String?> captureHeadshot() async {
    try {
      final String? base64Image = await _channel.invokeMethod('captureHeadshot');
      return base64Image;
    } catch (e) {
      developer.log('Error calling captureHeadshot: $e', name: 'CameraService');
      rethrow;
    }
  }
}
