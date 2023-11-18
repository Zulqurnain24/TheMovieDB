//
//  MovieServiceTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

class MovieServiceTests: XCTestCase {
    
    var sut: MovieServiceProtocol?

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetPopularMoviesWhenConnectedToInternetAndJsonIsCorrect() async {
        let networkingManager = TMDBFactory.createNetworkingManagerMock()
        networkingManager.jsonFileName = "MovieData"
        
        sut = MovieService(networkingManager: networkingManager, decoder: TMDBFactory.createDecoder())
        
        do {
            let movieResponse = try await sut?.getPopularMovies(1)
            
            XCTAssertEqual(movieResponse?.movies, [TheMovieDB.Movie(id: 872585, title: "Oppenheimer", voteAverage: 8.223, releaseDate: "2023-07-19", thumbnailPath: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg"), TheMovieDB.Movie(id: 507089, title: "Five Nights at Freddy\'s", voteAverage: 7.965, releaseDate: "2023-10-25", thumbnailPath: "/t5zCBSB5xMDKcDqe91qahCOUYVV.jpg"), TheMovieDB.Movie(id: 575264, title: "Mission: Impossible - Dead Reckoning Part One", voteAverage: 7.598, releaseDate: "2023-07-08", thumbnailPath: "/628Dep6AxEtDxjZoGP78TsOxYbK.jpg"), TheMovieDB.Movie(id: 299054, title: "Expend4bles", voteAverage: 6.47, releaseDate: "2023-09-15", thumbnailPath: "/wl4NWiZwpzZH67HiDgpDImLyds9.jpg"), TheMovieDB.Movie(id: 670292, title: "The Creator", voteAverage: 7.124, releaseDate: "2023-09-27", thumbnailPath: "/1AZcHRuWvmuUNhLj3XWcd54V80B.jpg"), TheMovieDB.Movie(id: 385687, title: "Fast X", voteAverage: 7.221, releaseDate: "2023-05-17", thumbnailPath: "/4XM8DUTQb3lhLemJC51Jx4a2EuA.jpg"), TheMovieDB.Movie(id: 678512, title: "Sound of Freedom", voteAverage: 8.086, releaseDate: "2023-07-03", thumbnailPath: "/pA3vdhadJPxF5GA1uo8OPTiNQDT.jpg"), TheMovieDB.Movie(id: 926393, title: "The Equalizer 3", voteAverage: 7.433, releaseDate: "2023-08-30", thumbnailPath: "/tC78Pck2YCsUAtEdZwuHYUFYtOj.jpg"), TheMovieDB.Movie(id: 609681, title: "The Marvels", voteAverage: 6.556, releaseDate: "2023-11-08", thumbnailPath: "/feSiISwgEpVzR1v3zv2n2AU4ANJ.jpg"), TheMovieDB.Movie(id: 800158, title: "The Killer", voteAverage: 6.79, releaseDate: "2023-10-25", thumbnailPath: "/mRmRE4RknbL7qKALWQDz64hWKPa.jpg"), TheMovieDB.Movie(id: 830764, title: "Pet Sematary: Bloodlines", voteAverage: 6.141, releaseDate: "2023-09-23", thumbnailPath: "/dRWhJ4godwy40JdmNuRZy23oViY.jpg"), TheMovieDB.Movie(id: 1172009, title: "The Black Book", voteAverage: 6.591, releaseDate: "2023-09-22", thumbnailPath: "/9WxqnP9c29wXd03sALSpxpTx8fk.jpg"), TheMovieDB.Movie(id: 951491, title: "Saw X", voteAverage: 7.412, releaseDate: "2023-09-26", thumbnailPath: "/dZbLqRjjiiNCpTYzhzL2NMvz4J0.jpg"), TheMovieDB.Movie(id: 565770, title: "Blue Beetle", voteAverage: 6.987, releaseDate: "2023-08-16", thumbnailPath: "/3H9NA1KWEQN0ItL3Wl3SFZYP6yV.jpg"), TheMovieDB.Movie(id: 980489, title: "Gran Turismo", voteAverage: 7.989, releaseDate: "2023-08-09", thumbnailPath: "/r7DuyYJ0N3cD8bRKsR5Ygq2P7oa.jpg"), TheMovieDB.Movie(id: 615656, title: "Meg 2: The Trench", voteAverage: 6.761, releaseDate: "2023-08-02", thumbnailPath: "/5mzr6JZbrqnqD8rCEvPhuCE5Fw2.jpg"), TheMovieDB.Movie(id: 811634, title: "The Monkey King: Reborn", voteAverage: 7.136, releaseDate: "2021-04-02", thumbnailPath: "/tv2xJzlQfwTHHls2ze8UeSheWgv.jpg"), TheMovieDB.Movie(id: 968051, title: "The Nun II", voteAverage: 6.916, releaseDate: "2023-09-06", thumbnailPath: "/gN79aDbZdaSJkFS1iVA17HplF2X.jpg"), TheMovieDB.Movie(id: 695721, title: "The Hunger Games: The Ballad of Songbirds & Snakes", voteAverage: 7.332, releaseDate: "2023-11-15", thumbnailPath: "/5a4JdoFwll5DRtKMe7JLuGQ9yJm.jpg"), TheMovieDB.Movie(id: 893723, title: "PAW Patrol: The Mighty Movie", voteAverage: 6.979, releaseDate: "2023-09-21", thumbnailPath: "/zgQQF04u3OgNBJqClRNby1FPz9s.jpg")])
            XCTAssertEqual(movieResponse?.totalPages, 41367)
        } catch {
            XCTFail("Should receive correct value for the movies. Error: \(error.localizedDescription)")
        }
    }
    
    func testGetPopularMoviesWhenConnectedToInternetAndJsonIsIncorrect() async {
        let networkingManager = TMDBFactory.createNetworkingManagerMock()
        networkingManager.jsonFileName = "MovieDataIncorrectJson"
        
        sut = MovieService(networkingManager: networkingManager, decoder: TMDBFactory.createDecoder())
        
        do {
            let movieResponse = try await sut?.getPopularMovies(1)
            
            XCTFail("Should throw decoding error")
        } catch {
            XCTAssertEqual(error as? MovieService.NetworkError, MovieService.NetworkError.decodingError)
        }
    }
    
    func testgetMovieDetailsWhenConnectedToInternetAndJsonIsCorrect() async {
        let networkingManager = NetworkingManagerMock.shared
        networkingManager.jsonFileName = "MovieDetailData"
        
        sut = MovieService(networkingManager: networkingManager, decoder: TMDBFactory.createDecoder())
        
        do {
            let movieDetails = try await sut?.getMovieDetails(for: 872585)
            
            XCTAssertEqual(movieDetails?.overview, "The story of J. Robert Oppenheimer\'s role in the development of the atomic bomb during World War II.")
            XCTAssertEqual(movieDetails?.posterPath, "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg")
            XCTAssertEqual(movieDetails?.title, "Oppenheimer")
            XCTAssertEqual(movieDetails?.homepage, "http://www.oppenheimermovie.com")
            XCTAssertEqual(movieDetails?.id, 872585)
            XCTAssertEqual(movieDetails?.voteAverage, 8.23)
        } catch {
            XCTFail("Should receive correct value for the movies. Error: \(error.localizedDescription)")
        }
    }
}
