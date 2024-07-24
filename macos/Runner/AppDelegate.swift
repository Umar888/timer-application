import Cocoa
import FlutterMacOS
import AVFoundation

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    private var cameraManager: CameraManager?

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    override func applicationWillFinishLaunching(_ notification: Notification) {
        print("Application will finish launching")
        requestCameraPermission { granted in
            if granted {
                print("Camera access granted")
            } else {
                print("Camera access denied")
            }
        }
        let controller = mainFlutterWindow?.contentViewController as! FlutterViewController
        let cameraChannel = FlutterMethodChannel(name: "com.camera", binaryMessenger: controller.engine.binaryMessenger)
        
        cameraChannel.setMethodCallHandler { [weak self] (call, result) in
            print("Received method call: \(call.method)")
            switch call.method {
            case "captureHeadshot":
                if #available(macOS 10.15, *) {
                    self?.captureHeadshot(result: result)
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Camera not supported on this macOS version", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        super.applicationDidFinishLaunching(notification)
    }
    private func requestCameraPermission(completion: @escaping (Bool) -> Void) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch authStatus {
            case .authorized:
                completion(true)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    completion(granted)
                }
            case .denied, .restricted:
                completion(false)
            @unknown default:
                completion(false)
            }
        }

    override func applicationDidBecomeActive(_ notification: Notification) {
        print("Application did become active")
    }

    private func captureHeadshot(result: @escaping FlutterResult) {
        print("captureHeadshot method called") // Log for debugging
        if #available(macOS 10.15, *) {
            cameraManager = CameraManager { image in
                if let image = image {
                    let imageData = image.tiffRepresentation
                    let base64String = imageData?.base64EncodedString()
                    result(base64String)
                } else {
                    result(FlutterError(code: "PHOTO_CAPTURE_FAILED", message: "Failed to capture photo", details: nil))
                }
            }
            cameraManager?.capturePhoto()
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Camera not supported on this macOS version", details: nil))
        }
    }
}
