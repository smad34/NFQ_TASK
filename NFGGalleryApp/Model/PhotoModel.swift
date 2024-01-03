//
//  PhotoModel.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.


import UIKit

struct PhotoModel {
    var image: UIImage
    var date: Date
    var tags: [String]
    var mode :Enumerates.CameraMode
}
extension PhotoModel {
    static func dummyData() -> [PhotoModel] {
        return [
            PhotoModel(image: UIImage(named: "image1")!, date: Date(), tags: ["Family", "Food"], mode: Enumerates.CameraMode.portrait),
            PhotoModel(image: UIImage(named: "image2")!, date: Date().addingTimeInterval(-3600), tags: ["Food", "Action"],mode: Enumerates.CameraMode.portrait),
            PhotoModel(image: UIImage(named: "image3")!, date: Date().addingTimeInterval(-4500), tags: ["Streetphotography"],mode: Enumerates.CameraMode.landscape),
            PhotoModel(image: UIImage(named: "image4")!, date: Date().addingTimeInterval(-6500), tags: ["Action,"],mode: Enumerates.CameraMode.portrait),
            PhotoModel(image: UIImage(named: "image5")!, date: Date().addingTimeInterval(-7200), tags: ["Streetphotography"],mode: Enumerates.CameraMode.portrait),
            PhotoModel(image: UIImage(named: "image6")!, date: Date().addingTimeInterval(-7900), tags: ["Food"],mode: Enumerates.CameraMode.landscape),
        ]
    }
}



