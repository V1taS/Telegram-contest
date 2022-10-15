//
//  PHAsset+FetchImage.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 15.10.2022.
//

import UIKit
import Photos

extension PHAsset {
  func fetchImage(targetSize size: CGSize,
                  contentMode: PHImageContentMode = .aspectFit,
                  options: PHImageRequestOptions? = nil,
                  completion: ((UIImage?) -> Void)?) {
    let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, info in
      completion?(image)
    }
    
    PHImageManager.default().requestImage(
      for: self,
      targetSize: size,
      contentMode: contentMode,
      options: options,
      resultHandler: resultHandler)
  }
}
