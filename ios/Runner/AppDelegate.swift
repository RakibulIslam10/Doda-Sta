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
        GMSServices.provideAPIKey("AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894")

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
