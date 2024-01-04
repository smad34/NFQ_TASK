//
//  GalleryViewTest.swift
//  NFGGalleryAppTests
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
//

import XCTest
@testable import NFGGalleryApp

class GalleryViewTests: XCTestCase {

    var galleryView: GalleryView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: ViewControllers.STORYBOARD, bundle: nil)
        galleryView = storyboard.instantiateViewController(withIdentifier: "GalleryView") as? GalleryView
        galleryView.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        galleryView = nil
        try super.tearDownWithError()
    }

    func testFilterButtonAction() {
        // Given
        let filterButton = UIButton()

        // When
        galleryView.FilterButtonAction(filterButton)

        // Then
        XCTAssertFalse(galleryView.tagsUIView.isHidden, "TagsUIView should be visible after FilterButtonAction")

        // Additional assertions if needed
        XCTAssertNotNil(galleryView.tagButtonsManager, "TagButtonsManager should be instantiated")
    }

    func testCancelButtonAction() {
        // Given
        let cancelButton = UIButton()

        // When
        galleryView.CancelButtonAction(cancelButton)

        // Then
        XCTAssertTrue(galleryView.tagsUIView.isHidden, "TagsUIView should be hidden after CancelButtonAction")

        // Additional assertions if needed
        // For example, if you expect photos to be reloaded after canceling, you can assert that the viewModel's photos array is not empty.
        XCTAssertFalse(galleryView.viewModel?.photos.isEmpty ?? true, "Photos should not be empty after CancelButtonAction")
    }
}
