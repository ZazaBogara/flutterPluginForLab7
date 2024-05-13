import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flash_light_control_plugin_platform_interface.dart';

class FlashLightControlPlugin {

  Future<String?> getPlatformVersion() {
    return FlashLightControlPluginPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel('flash_light_control_plugin');

  static Future<void> turnOn() async {
    try {
      await _channel.invokeMethod('turnOn');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to turn on the flashlight: '${e.message}'.");
      }
    }
  }

  static Future<void> turnOff() async {
    try {
      await _channel.invokeMethod('turnOff');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to turn off the flashlight: '${e.message}'.");
      }
    }
  }

  static Future<int?> getBatteryLevel() async {
    try {
      final int? batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get battery level: '${e.message}'.");
      }
      return null;
    }
  }
}