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
    var mode :cameraMode
}
extension PhotoModel {
    static func dummyData() -> [PhotoModel] {
        return [
            PhotoModel(image: UIImage(named: "image1")!, date: Date(), tags: ["Family", "Landscape"], mode: cameraMode.portrait),
            PhotoModel(image: UIImage(named: "image2")!, date: Date().addingTimeInterval(-3600), tags: ["Food", "Action"],mode: cameraMode.portrait),
            PhotoModel(image: UIImage(named: "image3")!, date: Date().addingTimeInterval(-4500), tags: ["Streetphotography"],mode: cameraMode.landscape),
            PhotoModel(image: UIImage(named: "image4")!, date: Date().addingTimeInterval(-6500), tags: ["Action,"],mode: cameraMode.portrait),
            PhotoModel(image: UIImage(named: "image5")!, date: Date().addingTimeInterval(-7200), tags: ["Streetphotography"],mode: cameraMode.portrait),
            PhotoModel(image: UIImage(named: "image6")!, date: Date().addingTimeInterval(-7900), tags: ["Food"],mode: cameraMode.landscape),
        ]
    }
}

public enum cameraMode: String {
    case portrait
    case landscape
}

