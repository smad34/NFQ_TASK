//
//  TagButtonManager.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

import UIKit

protocol TagButtonsDelegate: AnyObject {
    func tagButtonTapped(_ tag: String)
}

class TagButtonsManager {
    weak var delegate: TagButtonsDelegate?
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
        let limitedTags = Array(uniqueTags.prefix(7)) // Get the first 7 tags

        for tag in limitedTags {
            let button = UIButton(type: .system)
            button.setTitle(tag, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "colorSet2")
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.layer.cornerRadius = 5 
            button.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
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
        delegate?.tagButtonTapped(tag)
    }
}
