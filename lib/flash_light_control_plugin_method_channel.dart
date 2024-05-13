import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flash_light_control_plugin_platform_interface.dart';

/// An implementation of [FlashLightControlPluginPlatform] that uses method channels.
class MethodChannelFlashLightControlPlugin extends FlashLightControlPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flash_light_control_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
