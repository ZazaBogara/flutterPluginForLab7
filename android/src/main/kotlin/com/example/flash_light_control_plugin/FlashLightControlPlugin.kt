package com.example.flash_light_control_plugin

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager


class FlashLightControlPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flash_light_control_plugin")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "turnOn" -> turnOnFlashlight(result)
      "turnOff" -> turnOffFlashlight(result)
      "getBatteryLevel" -> getBatteryLevel(result)
      else -> result.notImplemented()
    }
  }

  private fun getBatteryLevel(result: Result) {
    val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    if (batteryLevel != -1) {
      result.success(batteryLevel)
    } else {
      result.error("BATTERY_LEVEL_ERROR", "Failed to get battery level.", null)
    }
  }


  private fun turnOnFlashlight(result: Result) {
    val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    try {
      val cameraId = cameraManager.cameraIdList[0]
      cameraManager.setTorchMode(cameraId, true)
      result.success(null)
    } catch (e: CameraAccessException) {
      result.error("CAMERA_ACCESS_ERROR", "Failed to access the camera for flashlight.", null)
    }
  }

  private fun turnOffFlashlight(result: Result) {
    val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    try {
      val cameraId = cameraManager.cameraIdList[0]
      cameraManager.setTorchMode(cameraId, false)
      result.success(null)
    } catch (e: CameraAccessException) {
      result.error("CAMERA_ACCESS_ERROR", "Failed to access the camera for flashlight.", null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}