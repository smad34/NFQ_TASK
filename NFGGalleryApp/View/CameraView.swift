//
//  CameraView.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
// CameraView :responsible for capturing photos using the device's back camera

import UIKit
import AVFoundation

class CameraView: SuperUIView, AVCapturePhotoCaptureDelegate {
    var viewModel: GalleryViewModel?

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    //MARK: - IBOutlets
    @IBOutlet weak var previewView: UIView!

    //MARK: - IBActions
    @IBAction func takePhotoButton(_ sender: UIButton) {
        // TODO: transfer data to the view model and update Gallery
       // let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
       // stillImageOutput.capturePhoto(with: settings, delegate: self)
        // viewModel?.addNewPhoto(...)
    }

    @IBAction func galleryButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

    //MARK: - overrides
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium

        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access back camera!")
            showToast(message: "Unable to access back camera!", type: Enumerates.ToastColor.error, lines: 1)
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
            } else {
                print("Unable to add input to capture session.")
                showToast(message: "Unable to add input to capture session.", type: Enumerates.ToastColor.error, lines: 1)
            }

            stillImageOutput = AVCapturePhotoOutput()
            if (captureSession.canAddOutput(stillImageOutput)) {
                captureSession.addOutput(stillImageOutput)
            } else {
                print("Unable to add output to capture session.")
                showToast(message: "Unable to add output to capture session.", type: Enumerates.ToastColor.error, lines: 1)
            }

            // Call the setupLivePreview function to start the live preview
            self.setupLivePreview()
        } catch let error {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
            showToast(message: "Error Unable to initialize back camera:  \(error.localizedDescription)"
                      , type: Enumerates.ToastColor.error, lines: 1)

        }
    }

    //MARK: - Main Functions
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        videoPreviewLayer.videoGravity = .resizeAspect
       // videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
}
