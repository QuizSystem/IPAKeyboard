//
//  UIImagePickerControllerExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit
import Photos
import AVFoundation

extension UIImagePickerController {
    public typealias ObtainPermissionHandler = () -> Void
    public static func obtainPermission(for mediaType: UIImagePickerControllerSourceType, success: ObtainPermissionHandler?, fail: ObtainPermissionHandler?) {
        switch mediaType {
        case .camera:
            obtainCameraPermission(success: success, fail: fail)
        default:
            obtainPhotoLibraryPermission(success: success, fail: fail)
        }
    }

    static func obtainCameraPermission(success: ObtainPermissionHandler?, fail: ObtainPermissionHandler?) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                success?()
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                fail?()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    if granted {
                        success?()
                    } else {
                        fail?()
                    }
                }
            })
        }
    }

    static func obtainPhotoLibraryPermission(success: ObtainPermissionHandler?, fail: ObtainPermissionHandler?) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            DispatchQueue.main.async {
                success?()
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                fail?()
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        success?()
                    }
                case .denied, .restricted:
                    DispatchQueue.main.async {
                        fail?()
                    }
                default:
                    break
                }
            })
        }
    }
}
