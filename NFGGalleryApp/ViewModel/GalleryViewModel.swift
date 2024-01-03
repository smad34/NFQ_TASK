//
//  GalleryViewModel.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

class GalleryViewModel {
    var photos: [PhotoModel] = []
    var filteredPhotos: [PhotoModel] = []

    func loadPhotos() {
        photos = PhotoModel.dummyData()
    }
    


}
