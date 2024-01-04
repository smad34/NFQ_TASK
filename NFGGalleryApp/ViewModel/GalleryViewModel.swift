//
//  GalleryViewModel.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//  implemente Business logics

import UIKit
import Photos

class GalleryViewModel {
    var filteredPhotos: [PhotoModel] = []

    //MARK: - closures
    var onPhotosUpdate: (() -> Void)?
    var photos: [PhotoModel] = [] {
        didSet {
            onPhotosUpdate?() // Call the closure when photos are updated
        }
    }

    //MARK: - Business logics functions

    func loadPhotos() {
       //TODO: uncommitted use real gallery
       //photos = GalleryViewModel.loadPhotosFromLibrary()
       photos = PhotoModel.dummyData()
    }

    func addNewPhoto(image: UIImage) {
        let newPhoto = PhotoModel(image: image, date: Date(), tags: [], mode: .portrait)
        photos.append(newPhoto)
    }

    func filterPhotosWithTag(_ tag: String) {
        let filteredPhotos = photos.filter { photo in
            photo.tags.contains(tag)
        }

        if  !filteredPhotos.isEmpty {
            photos = filteredPhotos
        } else {
            loadPhotos()
        }
        onPhotosUpdate?()
    }
}

//Mark: - get photos from library
extension GalleryViewModel {
    static func loadPhotosFromLibrary() -> [PhotoModel] {
        var result: [PhotoModel] = []
        let randomTags: [String] = ["Food","Action","Streetphotography","Family","Music"]
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(with: .image, options: options)

        fetchResult.enumerateObjects { (asset, _, _) in
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.isSynchronous = true

            imageManager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: requestOptions) { (image, _) in
                guard let image = image else {
                    return
                }

                let photoModel = PhotoModel(image: image, date: asset.creationDate ?? Date(), tags: [randomTags[.random(in: 0...3)]], mode: .portrait)
                result.append(photoModel)
            }
        }

        return result
    }
}
