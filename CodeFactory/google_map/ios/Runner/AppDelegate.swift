import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Info.plist에서 값을 읽어옵니다.
    let key = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String
    GMSServices.provideAPIKey(key ?? "")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}