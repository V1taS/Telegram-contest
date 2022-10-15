//
//  MainScreenView.swift
//  Telegram contest
//
//  Created by Vitalii Sosin on 11.10.2022.
//

import UIKit
import Photos

/// Events that we send from View to Presenter
protocol MainScreenViewOutput: AnyObject {
  
  /// An image has been selected
  /// - Parameters:
  ///  - image: Image
  ///  - indexPath: Image index
  func didSelectImage(_ image: UIImage?, at indexPath: IndexPath)
}

/// Events that we send from Presenter to View
protocol MainScreenViewInput: AnyObject {
  
  /// Настройка главного экрана
  ///  - Parameter models: Список моделек для ячейки
  func configureCellsWith(models: PHFetchResult<PHAsset>)
}

/// Protocol alias UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View for the screen
final class MainScreenView: MainScreenViewProtocol {
  
  /// Image display type
  enum ImageDisplayType {
    
    /// One picture in a row
    case onePictureInRow
    
    /// Three pictures in a row
    case threePicturesInRow
    
    /// Five pictures in a row
    case fivePicturesInRow
    
    /// Twelve pictures in a row
    case twelvePicturesInRow
  }
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties
  
  private let collectionViewLayout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
  private var models = PHFetchResult<PHAsset>()
  private var imageDisplayType: ImageDisplayType = .threePicturesInRow
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal func
  
  func configureCellsWith(models: PHFetchResult<PHAsset>) {
    self.models = models
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDelegate

extension MainScreenView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let image = models[indexPath.row]
    image.fetchImage(targetSize: .init(width: 300, height: 300)) { [weak self] image in
      guard let self = self else {
        return
      }
      self.output?.didSelectImage(image, at: indexPath)
    }
  }
}

// MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MainScreenCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? MainScreenCollectionViewCell else {
      return UICollectionViewCell()
    }
    let image = models[indexPath.row]
    cell.configureCellWith(image)
    return cell
  }
}

// MARK: - Private

private extension MainScreenView {
  func configureLayout() {
    let appearance = Appearance()
    
    [collectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                          constant: appearance.collectionViewInsets.top),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: appearance.collectionViewInsets.left),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -appearance.collectionViewInsets.right),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: -appearance.collectionViewInsets.bottom),
    ])
  }
  
  func applyDefaultBehavior() {
    let appearance = Appearance()
    backgroundColor = TGColor.primaryWhite
    collectionView.backgroundColor = TGColor.primaryWhite
    collectionView.alwaysBounceVertical = true
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(MainScreenCollectionViewCell.self,
                            forCellWithReuseIdentifier: MainScreenCollectionViewCell.reuseIdentifier)
    
    collectionViewLayout.sectionInset = appearance.sectionInset
    collectionViewLayout.scrollDirection = .vertical
    collectionViewLayout.minimumInteritemSpacing = appearance.minimumInteritemSpacing
    collectionViewLayout.minimumLineSpacing = appearance.minimumLineSpacing
    collectionViewLayout.itemSize = appearance.threePicturesInRow
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
    pinch.cancelsTouchesInView = false
    collectionView.addGestureRecognizer(pinch)
  }
  
  @objc
  func pinch(sender: UIPinchGestureRecognizer) {
    let appearance = Appearance()
    guard sender.state == .began else {
      return
    }
    
    let currentScale = collectionView.frame.size.width / collectionView.bounds.size.width
    let newScale = currentScale * sender.scale
    
    imageDisplayType = changeImageDisplayFrom(currentType: imageDisplayType, isZoomIn: newScale > 1)
    switch imageDisplayType {
    case .onePictureInRow:
      collectionViewLayout.itemSize = appearance.onePictureInRow
    case .threePicturesInRow:
      collectionViewLayout.itemSize = appearance.threePicturesInRow
    case .fivePicturesInRow:
      collectionViewLayout.itemSize = appearance.fivePicturesInRow
    case .twelvePicturesInRow:
      collectionViewLayout.itemSize = appearance.twelvePicturesInRow
    }
  }
  
  func changeImageDisplayFrom(currentType: ImageDisplayType, isZoomIn: Bool) -> ImageDisplayType {
    switch currentType {
    case .onePictureInRow:
      if isZoomIn {
        return .onePictureInRow
      } else {
        return .threePicturesInRow
      }
    case .threePicturesInRow:
      if isZoomIn {
        return .onePictureInRow
      } else {
        return .fivePicturesInRow
      }
    case .fivePicturesInRow:
      if isZoomIn {
        return .threePicturesInRow
      } else {
        return .twelvePicturesInRow
      }
    case .twelvePicturesInRow:
      if isZoomIn {
        return .fivePicturesInRow
      } else {
        return .twelvePicturesInRow
      }
    }
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {
    let collectionViewInsets: UIEdgeInsets = .zero
    let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    let onePictureInRow = CGSize(width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.width)
    let threePicturesInRow = CGSize(width: (UIScreen.main.bounds.width / 3) - 1,
                                    height: (UIScreen.main.bounds.width / 3) - 1)
    let fivePicturesInRow = CGSize(width: (UIScreen.main.bounds.width / 5) - 1,
                                   height: (UIScreen.main.bounds.width / 5) - 1)
    let twelvePicturesInRow = CGSize(width: (UIScreen.main.bounds.width / 12) - 1,
                                     height: (UIScreen.main.bounds.width / 12) - 1)
    let minimumInteritemSpacing: CGFloat = 1
    let minimumLineSpacing: CGFloat = 1
  }
}
