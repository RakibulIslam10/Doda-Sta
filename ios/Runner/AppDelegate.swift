import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Register Flutter plugins
        GeneratedPluginRegistrant.register(with: self)

        // Provide Google Maps API Key
        GMSServices.provideAPIKey("AIzaSyDNVuOBQjhjZlxvhBtowqjYN5_YsYfqezQ")

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
