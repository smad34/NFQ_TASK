//
//  TagButtonManager.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//  custom module for implement tags list and handle them

import UIKit

class PfUITagButton {
    var onTagButtonTapped: ((String) -> Void)?
    private var tagButtons: [UIButton] = []

    init(stackView: UIStackView, viewModel: GalleryViewModel) {
        createTagButtons(stackView: stackView, viewModel: viewModel)
    }

    private func createTagButtons(stackView: UIStackView, viewModel: GalleryViewModel) {
        // Clear existing buttons
        for button in tagButtons {
            button.removeFromSuperview()
        }
        tagButtons.removeAll()

        // Get the first 7 tags from the photos
        let allTags = viewModel.photos.flatMap { $0.tags }
        let uniqueTags = Array(Set(allTags)) // Remove duplicates
        let limitedTags = Array(uniqueTags.prefix(7)) // Get the first 7 tags (temporary)

        for tag in limitedTags {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(tag, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "colorSet2")
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.layer.cornerRadius = 5 
            button.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            button.configuration = configuration
            tagButtons.append(button)
        }
        for button in tagButtons {
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func tagButtonTapped(_ sender: UIButton) {
        guard let tag = sender.title(for: .normal) else {
            return
        }
        onTagButtonTapped?(tag)
    }
}
