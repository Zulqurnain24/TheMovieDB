//
//  ImageLoaderTests.swift
//  TheMovieDBTests
//
//  Created by Mohammad Zulqurnain on 18/11/2023.
//

import XCTest
@testable import TheMovieDB

// MARK: - ImageLoaderTests

class ImageLoaderTests: XCTestCase {
    
    var sut: ImageLoader?

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor func testLoadImageWhereThumbnailIsDownloadedFromInternet() async {
        
        let networkingManagerMock = TMDBFactory.createNetworkingManagerMock()
        
        networkingManagerMock.imageData = UIImage(named: "sampleThumbnail")?.pngData()
        
        sut = ImageLoader(persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkingManager: networkingManagerMock)
        
        try! await sut?.set(urlString: "/628Dep6AxEtDxjZoGP78TsOxYbK.jpg", type: .thumbnail)
        
        XCTAssertEqual(sut?.image?.pngData(), UIImage(named: "sampleThumbnail")?.pngData(), "Should return expected image data")
    }
    
    @MainActor func testLoadImageWherePosterIsDownloadedFromInternet() async {
        let networkingManagerMock = TMDBFactory.createNetworkingManagerMock()
        
        networkingManagerMock.imageData = UIImage(named: "samplePoster")?.pngData()
        
        sut = ImageLoader(persistentStoreManager: TMDBFactory.createPersistentStoreManagerMock(), networkingManager: networkingManagerMock)
        
        try! await sut?.set(urlString: "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", type: .poster)
        
        XCTAssertEqual(sut?.image?.pngData(), UIImage(named: "samplePoster")?.pngData(), "Should return expected image data")
    }
    
    @MainActor func testLoadImageWhereThumbnailIsDownloadedFromPersistenceStore() async {
        
        let persistentStoreManagerMock = TMDBFactory.createPersistentStoreManagerMock()
        
        let networkingManagerMock = TMDBFactory.createNetworkingManagerMock()
        
        networkingManagerMock.imageData = UIImage(named: "sampleThumbnail")?.pngData()
        
        sut = ImageLoader(persistentStoreManager: persistentStoreManagerMock, networkingManager: networkingManagerMock)
        
        try! await sut?.set(urlString: "/628Dep6AxEtDxjZoGP78TsOxYbK.jpg", type: .thumbnail)
        
        XCTAssertEqual(sut?.image?.pngData(), UIImage(named: "sampleThumbnail")?.pngData(), "Should return expected image data from networkingManager")
        
        let thumbnailData = persistentStoreManagerMock.getObject("/628Dep6AxEtDxjZoGP78TsOxYbK.jpg", Data.self)
        
        XCTAssertEqual(thumbnailData, UIImage(named: "sampleThumbnail")?.pngData(), "Should return expected image data from persistentStoreManager")
    }
    
    @MainActor func testLoadImageWherePosterIsDownloadedFromPersistenceStore() async {
        
        let persistentStoreManagerMock = TMDBFactory.createPersistentStoreManagerMock()
        
        let networkingManagerMock = TMDBFactory.createNetworkingManagerMock()
        
        networkingManagerMock.imageData = UIImage(named: "samplePoster")?.pngData()
        
        sut = ImageLoader(persistentStoreManager: persistentStoreManagerMock, networkingManager: networkingManagerMock)
        
        try! await sut?.set(urlString: "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", type: .poster)
        
        XCTAssertEqual(sut?.image?.pngData(), UIImage(named: "samplePoster")?.pngData(), "should return expected data from the networkingManager")
        
        let posterData = persistentStoreManagerMock.getObject("/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", Data.self)
        
        XCTAssertEqual(posterData, UIImage(named: "samplePoster")?.pngData(), "should return expected data from the persistentStoreManager")
    }
}
