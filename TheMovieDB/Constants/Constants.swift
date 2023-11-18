//
//  Constants.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import CoreFoundation

enum Constants {
    static let loadingHandlerNotSetError = "Loading handler is not set."
    
    static let movieImageMockUrlString = "https://image.tmdb.org/t/p/w500/628Dep6AxEtDxjZoGP78TsOxYbK.jpg"
    
    static let movieData = "MovieData"
    
    static let movies = "Movies"
    
    static let movie = "Movie"
    
    static let ratingLabel = "Rating:"
    
    static let releaseDateLabel = "Release Date:"
    
    static let thumbnailDimension = CGFloat(50)
    
    static let cornerRadius = CGFloat(5)
    
    static let smallSpacing = CGFloat(8)
    
    static let smallPadding = CGFloat(8)
    
    static let detailViewImageHeight = CGFloat(150)
    
    static let detailViewOverviewTitle = "Overview:"

    static let detailViewVistHomeButtonTitle = "Visit Homepage"
    
    static let movieMockId = Int(123)
    
    static let detailViewVStackVerticalPaddingPercentageWithRespectToGeometry = 0.15
   
    static let detailViewVStackHorizontalPaddingPercentageWithRespectToGeometry = 0.03
   
    static let movieMockTitle = "Mocked Title"
    
    static let movieMockRating = 5.5
    
    static let movieMockDate = "2021-10-13"
    
    static let movieMockPath = "/nohrh9aHNB1ehXmdtTZV5vStzcs.jpg"
    
    static let movieDetailsMockId = 1
    
    static let movieDetailsMockTitle = "Mocked Title"
    
    static let movieDetailsMockOverview = "Mocked Overview"
    
    static let movieDetailsMockPath = "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg"
    
    static let movieDetailsMockVoteAverage = 7.0
    
    static let movieDetailsHomePage = "https://www.oppenheimermovie.com/"
    
    static let getRequestType = "GET"

    static let logErrorPrefix = "[LOG] ❌ in"
    
    static let errorlabel = " Error:"
    
    static let logInfoPrefix = "[LOG] 💬 in"
    
    static let infolabel = " Info:"
    
    static let validStatusCodeRange = (200...300)
    
    static let networkInvaidErrorDescription = "URL isn't valid"
    
    static let networkInvalidStatusCode = "Status code falls into the wrong range"
    
    static let decodingErrorLabel = "Decoding error:"
    
    static let popularMovies = "Popular Movies"
    
    static let searchMovies = "Search movies"

    static let connectToInternet = "Please restore the internet connection and try again later"

    static let logStart = "<-Log-Start->"
    
    static let logEnd = "<-Log-End->"
}
