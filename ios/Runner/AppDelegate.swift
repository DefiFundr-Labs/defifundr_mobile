import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let iconChannel = FlutterMethodChannel(
      name: "com.defifundr.app/app_icon",
      binaryMessenger: controller.binaryMessenger
    )

    iconChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "supportsAlternateIcons":
        result(UIApplication.shared.supportsAlternateIcons)

      case "setAlternateIconName":
        let iconName = call.arguments as? String
        UIApplication.shared.setAlternateIconName(iconName) { error in
          if let error = error {
            result(FlutterError(
              code: "ICON_ERROR",
              message: error.localizedDescription,
              details: nil
            ))
          } else {
            result(nil)
          }
        }

      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
