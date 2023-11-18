//
//  TheMovieDBMovieListViewUITests.swift
//  TheMovieDBMovieListViewUITests
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import XCTest
@testable import TheMovieDB

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
             
        let popularMoviesText = app.staticTexts[Constants.popularMoviesTextIdentifier]
        XCTAssertTrue(popularMoviesText.waitForExistence(timeout: 5), "popularMoviesText should be visible")
        
        let searchMoviesTextField = app.textFields["searchMoviesTextField"]
        XCTAssertTrue(searchMoviesTextField.waitForExistence(timeout: 5), "searchMoviesTextField should be visible")
        
        let moviesList = app.collectionViews[Constants.movieListIdentifier]
      
        XCTAssertTrue(moviesList.waitForExistence(timeout: 5), "moviesList should be visible")
        
        let movieListViewRow = XCUIApplication().collectionViews[Constants.movieListIdentifier].staticTexts["Oppenheimer"]
        XCTAssertTrue(movieListViewRow.waitForExistence(timeout: 5), "movieListViewRow should be visible")
                
    }
    
    func testSearchAndSegueToDetailOfFirstResult() {
        
        let app = XCUIApplication()
        app.textFields[Constants.searchMoviesTextfieldAccessIdentifier].tap()
        app.collectionViews[Constants.movieListIdentifier]
           .staticTexts["Rating: 8.2"].tap()

    }
    
    func testInfiniteScrollingOnMovieListAndTapOnMovieListViewRow() {
     
        let movieslistCollectionView = XCUIApplication().collectionViews[Constants.movieListIdentifier]
 
        for _ in 0..<10 {
            movieslistCollectionView.swipeUp()
        }
    }
    
    func testSegueToDetailViewScrollToTheBottomAndPressThevisitHomepageLink() {
     
        let movieslistCollectionView = XCUIApplication().collectionViews[Constants.movieListIdentifier]
 
        XCUIApplication().collectionViews[Constants.movieListIdentifier]
                         .buttons["Oppenheimer, Rating: 8.2, Release Date: 2023-07-19"].tap()
        
        let movieTitleText = app.staticTexts[Constants.detailViewMovieTitleAccessIdentifier]
        XCTAssertTrue(movieTitleText.waitForExistence(timeout: 5), "movieTitleText should be visible")
        
        let overviewLabelText = app.staticTexts[Constants.detailViewOverviewLabelIdentifier]
        XCTAssertTrue(overviewLabelText.waitForExistence(timeout: 5), "overviewLabelText should be visible")
        
        let overviewValueText = app.staticTexts[Constants.detailViewOverviewValueIdentifier]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "overviewValueText should be visible")
        
        let ratingText = app.staticTexts[Constants.detailViewRatingTextIdentifier]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "ratingText should be visible")
        
        let visitHomepageLink = app.buttons[Constants.detailViewVistHomeButtonTitleIdentifier]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "visitHomepageLink should be visible")
       
        visitHomepageLink.tap()
    }
    
    func testSegueToDetailViewAndNavigateBack() {
        let movieslistCollectionView = XCUIApplication().collectionViews[Constants.movieListIdentifier]
 
        XCUIApplication().collectionViews[Constants.movieListIdentifier]
                         .buttons["Oppenheimer, Rating: 8.2, Release Date: 2023-07-19"].tap()
        
        let movieTitleText = app.staticTexts[Constants.detailViewMovieTitleAccessIdentifier]
        XCTAssertTrue(movieTitleText.waitForExistence(timeout: 5), "movieTitleText should be visible")
        
        let overviewLabelText = app.staticTexts[Constants.detailViewOverviewLabelIdentifier]
        XCTAssertTrue(overviewLabelText.waitForExistence(timeout: 5), "overviewLabelText should be visible")
        
        let overviewValueText = app.staticTexts[Constants.detailViewOverviewValueIdentifier]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "overviewValueText should be visible")
        
        let ratingText = app.staticTexts[Constants.detailViewRatingTextIdentifier]
        XCTAssertTrue(overviewValueText.waitForExistence(timeout: 5), "ratingText should be visible")
        
        let visitHomepageLink = app.buttons[Constants.detailViewVistHomeButtonTitleIdentifier]
        
        let backButton = app.buttons.firstMatch
        backButton.tap()
    }
}

