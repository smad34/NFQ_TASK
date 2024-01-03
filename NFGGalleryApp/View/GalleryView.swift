//
//  GalleryView.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

import UIKit

class GalleryView: UIViewController {
    var viewModel: GalleryViewModel?
    @IBOutlet var mainCollectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = GalleryViewModel()
        viewModel?.loadPhotos()
        
    }

    
    private func setupUI() {
       // let layout = UICollectionViewFlowLayout()
       // mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        mainCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.reloadData()

    }
}

extension GalleryView: UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseIdentifier, for: indexPath) as? GalleryCell else {
            fatalError("Unable to dequeue GalleryCell")
        }
        if let photo = viewModel?.photos[indexPath.item] {
                   cell.configure(with: photo)
               }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath)->CGSize {
        let photo = viewModel?.photos[indexPath.item]

        if photo!.mode == .portrait {

                } else {

                }
        return CGSize(width: 160 , height: 200)

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
       }

}
