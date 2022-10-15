//
//  MainScreenInteractor.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit
import Photos

/// Events that we send from Interactor to Presenter
protocol MainScreenInteractorOutput: AnyObject {
  
  /// Images were taken
  ///  - Parameter allImages: All images
  func didReceive(allImages: PHFetchResult<PHAsset>)
}

/// Events sent from Presenter to Interactor
protocol MainScreenInteractorInput {
  
  /// Get a list of images
  func getContent()
}

/// Interactor
final class MainScreenInteractor: MainScreenInteractorInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenInteractorOutput?
  
  // MARK: - Internal func
  
  func getContent() {
    let allImagesOptions = PHFetchOptions()
    allImagesOptions.sortDescriptors = [
      NSSortDescriptor(
        key: Appearance().sortDescriptorKey,
        ascending: false)
    ]
    let allPImages = PHAsset.fetchAssets(with: allImagesOptions)
    output?.didReceive(allImages: allPImages)
  }
}

// MARK: - Appearance

private extension MainScreenInteractor {
  struct Appearance {
    let sortDescriptorKey = "creationDate"
  }
}
