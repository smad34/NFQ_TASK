//
//  GalleryView.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

import UIKit

class GalleryView: UIViewController {
    var viewModel: GalleryViewModel?
    var selectedIndexPaths: Set<IndexPath> = Set()
    var tagButtons: [UIButton] = []

    @IBOutlet var mainCollectionView:UICollectionView!
    @IBOutlet weak var tagsStackView: UIStackView!

    @IBAction func FilterButtonAction(_ sender: UIButton) {
        tagsUIView.isHidden = false
        createTagButtons()
    }
    
    @IBAction func CancelButtonAction(_ sender: UIButton) {
        tagsUIView.isHidden = true
        viewModel?.loadPhotos()
        filterPhotosWithTag("")
    }
    @IBOutlet weak var tagsUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = GalleryViewModel()
        viewModel?.loadPhotos()
    }


    private func setupUI() {
        mainCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.reloadData()
      }

    private func createTagButtons() {
        // Clear existing buttons
        for button in tagButtons {
            button.removeFromSuperview()
        }
        tagButtons.removeAll()

        // Get the first 7 tags from the photos
        let allTags = viewModel!.photos.flatMap { $0.tags }
        let uniqueTags = Array(Set(allTags)) // Remove duplicates
        let limitedTags = Array(uniqueTags.prefix(7)) // Get the first 7 tags

        for tag in limitedTags {
            let button = UIButton(type: .system)
                button.setTitle(tag, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor(named: "colorSet2")
                button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) // Add padding
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
                button.layer.cornerRadius = 5 // Optional: Add rounded corners for a nicer appearance
                button.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
                tagButtons.append(button)
        }

        // Add buttons to the stack view
        for button in tagButtons {
            tagsStackView.addArrangedSubview(button)
        }
    }

       @objc func tagButtonTapped(_ sender: UIButton) {
           // Handle button tap event
           guard let tag = sender.title(for: .normal) else { return }
           filterPhotosWithTag(tag)
       }

       private func filterPhotosWithTag(_ tag: String) {
           // Filter photos based on the selected tag
           let filteredPhotos = viewModel?.photos.filter { photo in
               return photo.tags.contains(tag)
           }

           if let filteredPhotos = filteredPhotos, !filteredPhotos.isEmpty {
               viewModel?.photos = filteredPhotos
           } else {
               viewModel?.loadPhotos()
           }
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
                //TODO: -
                } else {
                    //TODO: -
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

