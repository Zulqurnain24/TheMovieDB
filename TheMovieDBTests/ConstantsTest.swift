//
//  ConstantsTest.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

class ConstantsTest: XCTestCase {
 
    func testValues() {
        XCTAssertEqual(Constants.loadingHandlerNotSetError, "Loading handler is not set.")
        
        XCTAssertEqual(Constants.movieImageMockUrlString, "https://image.tmdb.org/t/p/w500/628Dep6AxEtDxjZoGP78TsOxYbK.jpg")
        
        XCTAssertEqual(Constants.movieData, "MovieData")
        
        XCTAssertEqual(Constants.movies, "Movies")
        
        XCTAssertEqual(Constants.movie, "Movie")
        
        XCTAssertEqual(Constants.ratingLabel, "Rating:")
        
        XCTAssertEqual(Constants.releaseDateLabel, "Release Date:")
        
        XCTAssertEqual(Constants.thumbnailDimension, CGFloat(50))
        
        XCTAssertEqual(Constants.cornerRadius, CGFloat(5))
        
        XCTAssertEqual(Constants.smallPadding, CGFloat(8))
        
        XCTAssertEqual(Constants.detailViewImageHeight, CGFloat(150))
        
        XCTAssertEqual(Constants.detailViewOverviewTitle, "Overview:")
        
        XCTAssertEqual(Constants.detailViewOverviewTitleIdentifier, "overviewLabelText")
     
        XCTAssertEqual(Constants.detailViewOverviewValueIdentifier, "overviewValueText")
        
        XCTAssertEqual(Constants.detailViewRatingTextIdentifier, "ratingText")
        
        XCTAssertEqual(Constants.detailViewVistHomeButtonTitle, "Visit Homepage")
        
        XCTAssertEqual(Constants.movieMockId, Int(123))
        
        XCTAssertEqual(Constants.detailViewVStackVerticalPaddingPercentageWithRespectToGeometry, 0.15)
        
        XCTAssertEqual(Constants.detailViewVStackHorizontalPaddingPercentageWithRespectToGeometry, 0.03)
       
        XCTAssertEqual(Constants.movieListIdentifier, "moviesList")
        
        XCTAssertEqual(Constants.detailViewVistHomeButtonTitleIdentifier, "visitHomepageLink")
     
        XCTAssertEqual(Constants.movieMockTitle, "Mocked Title")
        
        XCTAssertEqual(Constants.movieMockRating, 5.5)
        
        XCTAssertEqual(Constants.movieMockDate, "2021-10-13")
        
        XCTAssertEqual(Constants.movieMockPath, "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg")
        
        XCTAssertEqual(Constants.movieDetailsMockId, 1)
        
        XCTAssertEqual(Constants.movieDetailsMockTitle, "Mocked Title")
        
        XCTAssertEqual(Constants.movieDetailsMockOverview, "Mocked Overview")
        
        XCTAssertEqual(Constants.movieDetailsMockPath, "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg")
        
        XCTAssertEqual(Constants.movieDetailsMockVoteAverage, 7.0)
        
        XCTAssertEqual(Constants.movieDetailsHomePage, "https://www.oppenheimermovie.com/")
        
        XCTAssertEqual(Constants.getRequestType, "GET")
        
        XCTAssertEqual(Constants.logErrorPrefix, "[LOG] ❌ in")
        
        XCTAssertEqual(Constants.errorlabel, " Error:")
        
        XCTAssertEqual(Constants.logInfoPrefix, "[LOG] 💬 in")
        
        XCTAssertEqual(Constants.infolabel, " Info:")
        
        XCTAssertEqual(Constants.validStatusCodeRange, (200...300))
        
        XCTAssertEqual(Constants.networkInvaidErrorDescription, "URL isn't valid")
        
        XCTAssertEqual(Constants.networkInvalidStatusCode, "Status code falls into the wrong range")
        
        XCTAssertEqual(Constants.decodingErrorLabel, "Decoding error:")
        
        XCTAssertEqual(Constants.popularMovies, "Popular Movies")
        
        XCTAssertEqual(Constants.popularMoviesTextIdentifier, "popularMoviesText")
        
        XCTAssertEqual(Constants.searchMovies, "Search movies")
        
        XCTAssertEqual(Constants.searchMoviesTextfieldAccessIdentifier, "searchMoviesTextField")
        
        XCTAssertEqual(Constants.connectToInternet, "Please restore the internet connection and try again later")
        
        XCTAssertEqual(Constants.connectToInternetTextAccessIdentifier, "restoreNetConnectionText")
        
        XCTAssertEqual(Constants.detailViewMovieTitleAccessIdentifier, "movieTitleText")
    }
    
}
