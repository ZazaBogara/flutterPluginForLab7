import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flash_light_control_plugin_platform_interface.dart';
import 'dart:io'; // Import 'dart:io' to access Platform

class FlashLightControlPlugin {

  Future<String?> getPlatformVersion() {
    return FlashLightControlPluginPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel('flash_light_control_plugin');

  static Future<void> turnOn() async {
    try {
      // Check if the current platform is Android
      if (Platform.isAndroid) {
        await _channel.invokeMethod('turnOn');
      } else {
        // For other platforms, just print a success message
        print("Flashlight is on");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to turn on the flashlight: '${e.message}'.");
      }
    }
  }

  static Future<void> turnOff() async {
    try {
      // Check if the current platform is Android
      if (Platform.isAndroid) {
        await _channel.invokeMethod('turnOff');
      } else {
        // For other platforms, just print a success message
        print("Flashlight is off");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to turn off the flashlight: '${e.message}'.");
      }
    }
  }

  static Future<int?> getBatteryLevel() async {
    try {
      // Check if the current platform is Android
      if (Platform.isAndroid) {
        final int? batteryLevel = await _channel.invokeMethod('getBatteryLevel');
        return batteryLevel;
      } else {
        // For other platforms, just return null
        return null;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get battery level: '${e.message}'.");
      }
      return null;
    }
  }
}
