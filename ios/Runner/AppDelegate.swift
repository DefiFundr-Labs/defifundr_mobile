import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let iconChannel = FlutterMethodChannel(
      name: "com.defifundr.app/app_icon",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    iconChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "supportsAlternateIcons":
        result(UIApplication.shared.supportsAlternateIcons)
      case "setAlternateIconName":
        let iconName = call.arguments as? String
        UIApplication.shared.setAlternateIconName(iconName) { error in
          if let error = error {
            result(FlutterError(code: "ICON_ERROR", message: error.localizedDescription, details: nil))
          } else {
            result(nil as Any?)
          }
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
