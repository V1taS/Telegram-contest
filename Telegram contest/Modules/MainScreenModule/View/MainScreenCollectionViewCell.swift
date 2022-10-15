//
//  MainScreenCollectionViewCell.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 12.10.2022.
//

import UIKit
import Photos

// MARK: - MainScreenCollectionViewCell

final class MainScreenCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Public property
  
  /// Identifier for the cell
  static let reuseIdentifier = MainScreenCollectionViewCell.description()
  
  // MARK: - Private property
  
  private let imageView = UIImageView()
  
  // MARK: - Initilisation
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError()
  }
  
  // MARK: - Internal func
  
  /// Setting up a cell
  /// - Parameter asset: A representation of an image, video, or Live Photo in the Photos library.
  func configureCellWith(_ asset: PHAsset) {
    fetchImageAsset(asset,
                    targetSize: .init(width: 300, height: 300)) { [weak self] image in
      guard let self = self else {
        return
      }
      self.imageView.image = image
    }
  }
}

// MARK: - Private

private extension MainScreenCollectionViewCell {
  func configureLayout() {
    [imageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leftAnchor.constraint(equalTo: leftAnchor),
      imageView.rightAnchor.constraint(equalTo: rightAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func applyDefaultBehavior() {
    backgroundColor = TGColor.primaryWhite
    
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
  }
  
  func fetchImageAsset(_ asset: PHAsset,
                       targetSize size: CGSize,
                       contentMode: PHImageContentMode = .aspectFit,
                       options: PHImageRequestOptions? = nil,
                       completion: ((UIImage?) -> Void)?) {
    let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, info in
      completion?(image)
    }

    PHImageManager.default().requestImage(
      for: asset,
      targetSize: size,
      contentMode: contentMode,
      options: options,
      resultHandler: resultHandler)
  }
}

// MARK: - Appearance

private extension MainScreenCollectionViewCell {
  struct Appearance {}
}
