//
//  GalleryViewModel.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

import UIKit

class GalleryViewModel {
    var photos: [PhotoModel] = []
    var filteredPhotos: [PhotoModel] = []

    func loadPhotos() {
        photos = PhotoModel.dummyData()
    }

    func addNewPhoto(image: UIImage) {
        let newPhoto = PhotoModel(image: image, date: Date(), tags: [], mode: .portrait)
        photos.append(newPhoto)
    }
}
