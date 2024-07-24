import AVFoundation
import Cocoa

@available(macOS 10.15, *)
class CameraManager: NSObject, AVCapturePhotoCaptureDelegate {
    private var captureSession: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    private var photoCompletion: ((NSImage?) -> Void)?

    init(photoCompletion: @escaping (NSImage?) -> Void) {
        self.photoCompletion = photoCompletion
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = .high
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified).devices
        print("Available devices: \(devices)")

        guard let camera = AVCaptureDevice.default(for: .video) else {
            print("No camera available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                print("Cannot add camera input")
                return
            }
            
            photoOutput = AVCapturePhotoOutput()
            if let photoOutput = photoOutput, session.canAddOutput(photoOutput) {
                session.addOutput(photoOutput)
            } else {
                print("Cannot add photo output")
                return
            }
            
            session.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation(), let image = NSImage(data: data) {
            photoCompletion?(image)
        } else {
            photoCompletion?(nil)
        }
    }
}
