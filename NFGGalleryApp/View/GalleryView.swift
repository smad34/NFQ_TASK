//
//  GalleryView.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//  GalleryView : display a gallery of photos with tag-based filtering functionality.

import UIKit

class GalleryView: SuperUIView {
    var viewModel: GalleryViewModel?
    var selectedIndexPaths: Set<IndexPath> = Set()
    var tagButtonsManager: TagButtonsManager?

    @IBOutlet var tagsUIView: UIView!
    @IBOutlet var mainCollectionView: UICollectionView!
    @IBOutlet var tagsStackView: UIStackView!

    @IBAction func FilterButtonAction(_ sender: UIButton) {
        tagsUIView.isHidden = false
        tagButtonsManager = TagButtonsManager(stackView: tagsStackView, viewModel: viewModel!)
        tagButtonsManager?.delegate = self
    }

    @IBAction func CancelButtonAction(_ sender: UIButton) {
        tagsUIView.isHidden = true
        viewModel?.loadPhotos()
        filterPhotosWithTag("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initData()
    }

    private func initData() {
        viewModel = GalleryViewModel()
        viewModel?.loadPhotos()
    }

    private func setupUI() {
        guard mainCollectionView != nil else {
                fatalError("mainCollectionView is nil. Check your IBOutlet connection.")
            }
        mainCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.reloadData()
    }

    private func filterPhotosWithTag(_ tag: String) {
           let filteredPhotos = viewModel?.photos.filter { photo in
               photo.tags.contains(tag)
           }

           if let filteredPhotos = filteredPhotos, !filteredPhotos.isEmpty {
               viewModel?.photos = filteredPhotos
           } else {
               viewModel?.loadPhotos()
           }
           mainCollectionView.reloadData()
       }
}

extension GalleryView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = viewModel?.photos[indexPath.item]

        if photo!.mode == .portrait {
            // TODO: - portrait configuration
        } else {
            // TODO: - landscape configuration
        }
        return CGSize(width: 160, height: 200)
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

extension GalleryView: TagButtonsDelegate {
    func tagButtonTapped(_ tag: String) {
        filterPhotosWithTag(tag)
    }
}
