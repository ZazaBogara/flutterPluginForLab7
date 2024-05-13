import 'package:flutter_test/flutter_test.dart';
import 'package:flash_light_control_plugin/flash_light_control_plugin.dart';
import 'package:flash_light_control_plugin/flash_light_control_plugin_platform_interface.dart';
import 'package:flash_light_control_plugin/flash_light_control_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlashLightControlPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlashLightControlPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlashLightControlPluginPlatform initialPlatform = FlashLightControlPluginPlatform.instance;

  test('$MethodChannelFlashLightControlPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlashLightControlPlugin>());
  });

  test('getPlatformVersion', () async {
    FlashLightControlPlugin flashLightControlPlugin = FlashLightControlPlugin();
    MockFlashLightControlPluginPlatform fakePlatform = MockFlashLightControlPluginPlatform();
    FlashLightControlPluginPlatform.instance = fakePlatform;

    expect(await flashLightControlPlugin.getPlatformVersion(), '42');
  });
}
