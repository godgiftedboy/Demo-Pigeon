import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let controller = window?.rootViewController as! FlutterViewController
    let api = PigeonApiImplementation()
    ExampleHostApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: api)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// #docregion swift-class
private class PigeonApiImplementation: ExampleHostApi {
  func getHostLanguage() throws -> String {
    return "Swift"
  }

  func add(_ a: Int64, to b: Int64) throws -> Int64 {
    if a < 0 || b < 0 {
      throw PigeonError(code: "code", message: "message", details: "details")
    }
    return a + b
  }

  func sendMessage(message: MessageData, completion: @escaping (Result<Bool, Error>) -> Void) {
    if message.code == Code.one {
      completion(.failure(PigeonError(code: "code", message: "message", details: "details")))
      return
    }
    completion(.success(true))
  }
}
