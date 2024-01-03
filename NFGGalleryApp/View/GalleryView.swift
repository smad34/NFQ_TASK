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

    @IBOutlet var mainCollectionView:UICollectionView!
    @IBOutlet var tagsViewContainer:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTags()
        handleLongPress()
        viewModel = GalleryViewModel()
        viewModel?.loadPhotos()
    }

    private func setupUI() {
        mainCollectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.reloadData()
    }

    private func handleLongPress(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mainCollectionView.addGestureRecognizer(longPressGesture)
    }
    private func setupTags(){
        var previousButton: UIButton?

        let buttonTitles = ["Button 1", "Button 2", "Button 3", "Button 4"]

              // Loop through the button titles and create buttons
              for title in buttonTitles {
                  let button = UIButton(type: .system)
                  button.setTitle(title, for: .normal)
                  button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

                  // Set any other properties you may need (e.g., button frame, color, etc.)
                  button.translatesAutoresizingMaskIntoConstraints = false

                  // Add the button to the view
                  tagsViewContainer.addSubview(button)
                  // Set up constraints
                             NSLayoutConstraint.activate([
                                 button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                 button.heightAnchor.constraint(equalToConstant: 40),

                                 // Leading constraint to the previous button or leading of the superview for the first button
                                 button.leadingAnchor.constraint(equalTo: previousButton?.trailingAnchor ?? view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                             ])

                             // Update the previousButton for the next iteration
                             previousButton = button
              }
    }

    @objc func buttonTapped(_ sender: UIButton) {
         // Handle button tap event
         print("Button tapped: \(sender.title(for: .normal) ?? "")")
     }
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                // Get the tapped point in the collection view
                let point = gesture.location(in: mainCollectionView)

                // Find the indexPath of the cell at the tapped point
                if let indexPath = mainCollectionView.indexPathForItem(at: point) {
                    // Toggle the selection state of the cell
                    if selectedIndexPaths.contains(indexPath) {
                        selectedIndexPaths.remove(indexPath)
                    } else {
                        selectedIndexPaths.insert(indexPath)
                    }

                    // Update the UI to reflect the selection changes
                    mainCollectionView.reloadItems(at: [indexPath])
                }
            }
        }

    // Implement a method to handle deletion based on the selectedIndexPaths set
    func deleteSelectedPhotos() {
        let selectedPhotos = selectedIndexPaths.compactMap { indexPath in
            return viewModel?.photos[indexPath.item]
        }

        // Perform your deletion logic here, e.g., updating the data source
        viewModel?.deletePhotos(selectedPhotos)

        // Clear the selection
        selectedIndexPaths.removeAll()

        // Reload the collection view to reflect the changes
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
