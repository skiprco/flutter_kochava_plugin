import Flutter
import UIKit
//import KochavaTrackeriOSE

public class SwiftFlutterKochavaPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_kochava_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterKochavaPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
