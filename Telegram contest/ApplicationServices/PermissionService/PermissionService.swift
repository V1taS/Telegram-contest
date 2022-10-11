//
//  PermissionService.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit
import Photos

protocol PermissionService {
  
  /// Request access to the Camera
  /// - Parameter status: Access granted
  func requestCamera(_ status: ((_ granted: Bool) -> Void)?)
  
  /// Request access to the Gallery
  /// - Parameter status: Access granted
  func requestPhotos(_ status: ((_ granted: Bool) -> Void)?)
  
  /// Get authorization status to the Gallery
  /// - Parameter status: Access granted
  func isAuthorizationStatus() -> Bool
}

final class PermissionServiceImpl: PermissionService {
  func requestCamera(_ status: ((_ granted: Bool) -> Void)?) {
    AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
      DispatchQueue.main.async {
        status?(granted)
      }
    }
  }
  
  func requestPhotos(_ status: ((_ granted: Bool) -> Void)?) {
    if #available(iOS 14, *) {
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { (resultStatus) in
        DispatchQueue.main.async {
          switch resultStatus {
          case .denied, .notDetermined, .restricted:
            status?(false)
          case .authorized, .limited:
            status?(true)
          @unknown default:
            status?(false)
          }
        }
      }
    } else {
      PHPhotoLibrary.requestAuthorization({ resultStatus in
        DispatchQueue.main.async {
          switch resultStatus {
          case .denied, .notDetermined, .restricted:
            status?(false)
          case .authorized, .limited:
            status?(true)
          @unknown default:
            status?(false)
          }
        }
      })
    }
  }
  
  func isAuthorizationStatus() -> Bool {
    switch PHPhotoLibrary.authorizationStatus() {
    case .denied, .notDetermined, .restricted:
      return false
    case .authorized, .limited:
      return true
    @unknown default:
      return false
    }
  }
}
