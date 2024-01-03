//
//  GalleryViewModel.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

class GalleryViewModel {
    var photos: [PhotoModel] = []
    
    func loadPhotos() {
        photos = PhotoModel.dummyData()
    }
    
    func deletePhotos(_ photos: [PhotoModel]) {
        // Implement your deletion logic here, e.g., remove the selected photos from the photos array
        self.photos.removeAll { existingPhoto in
            return photos.contains { photoToDelete in
                // Use a unique identifier for comparison, e.g., image or date
                return existingPhoto.image === photoToDelete.image
            }
        }
    }
}
