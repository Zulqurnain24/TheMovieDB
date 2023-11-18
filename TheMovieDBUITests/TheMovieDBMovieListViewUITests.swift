//
//  TheMovieDBMovieListViewUITests.swift
//  TheMovieDBMovieListViewUITests
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import XCTest

// MARK: - TheMovieDBMovieListViewUITests

final class TheMovieDBMovieListViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testTextAttributesAndListAppearance() {
        
        let popularMoviesText = app.staticTexts["popularMoviesText"]
        XCTAssertTrue(popularMoviesText.waitForExistence(timeout: 5), "popularMoviesText should be visible")
        
        let searchMoviesTextField = app.textFields["searchMoviesTextField"]
        XCTAssertTrue(searchMoviesTextField.waitForExistence(timeout: 5), "searchMoviesTextField should be visible")
        
        let moviesList = app.collectionViews["moviesList"]
        
        XCTAssertTrue(moviesList.waitForExistence(timeout: 5), "moviesList should be visible")
        
        let movieListViewRow = XCUIApplication().collectionViews["moviesList"].staticTexts["Oppenheimer"]
        XCTAssertTrue(movieListViewRow.waitForExistence(timeout: 5), "movieListViewRow should be visible")
        
    }
    
    func testSearchAndSegueToDetailOfFirstResult() {
        
        let app = XCUIApplication()
        app.textFields["searchMoviesTextField"].tap()
        app.collectionViews["moviesList"]
            .staticTexts["Rating: 8.2"].tap()
        
    }
    
    func testInfiniteScrollingOnMovieListAndTapOnMovieListViewRow() {
        
        let movieslistCollectionView = XCUIApplication().collectionViews["moviesList"]
        
        for _ in 0..<10 {
            movieslistCollectionView.swipeUp()
        }
    }
    
    func testSegueToDetailViewScrollToTheBottomAndPressThevisitHomepageLink() {
        
        let movieListView = XCUIApplication().collectionViews["moviesList"]
        
        movieListView.buttons["Oppenheimer, Rating: 8.2, Release Date: 2023-07-19"].tap()
        
        let movieTitleText = app.staticTexts["movieTitleText"]
        XCTAssertTrue(movieTitleText.waitForExistence(timeout: 5), "movieTitleText should be visible")
        
        let overviewLabelText = app.staticTexts["overviewLabelText"]
        XCTAssertTrue(overviewLabelText.waitForExistence(timeout: 5), "overviewLabelText should be visible")
        
        let overviewValueText = app.staticTexts["overviewValueText"]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "overviewValueText should be visible")
        
        let ratingText = app.staticTexts["ratingText"]
        XCTAssertTrue(ratingText.waitForExistence(timeout: 5), "ratingText should be visible")
        
        let visitHomepageLink = app.buttons["visitHomepageLink"]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "visitHomepageLink should be visible")
        
        visitHomepageLink.tap()
    }
    
    func testSegueToDetailViewAndNavigateBack() {
        let movieListView = XCUIApplication().collectionViews["moviesList"]
        
        movieListView.buttons["Oppenheimer, Rating: 8.2, Release Date: 2023-07-19"].tap()
        
        let movieTitleText = app.staticTexts["movieTitleText"]
        XCTAssertTrue(movieTitleText.waitForExistence(timeout: 5), "movieTitleText should be visible")
        
        let overviewLabelText = app.staticTexts["overviewLabelText"]
        XCTAssertTrue(overviewLabelText.waitForExistence(timeout: 5), "overviewLabelText should be visible")
        
        let overviewValueText = app.staticTexts["overviewValueText"]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "overviewValueText should be visible")
        
        let ratingText = app.staticTexts["ratingText"]
        XCTAssertTrue(ratingText.waitForExistence(timeout: 5), "ratingText should be visible")
        
        let visitHomepageLink = app.buttons["visitHomepageLink"]
        XCTAssertTrue(visitHomepageLink.waitForExistence(timeout: 5), "ratingText should be visible")
        
        let backButton = app.buttons.firstMatch
        backButton.tap()
    }
}

