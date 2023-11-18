//
//  ImageLoader.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import SwiftUI

@MainActor
protocol ImageLoaderProtocol: ObservableObject {
    var image: UIImage? { get set }
    
    func set(urlString: String, type: ImageLoader.ImageType) async throws
    func populateURL(_ type: ImageLoader.ImageType)
    func loadImage() async throws
}

// MARK: - ImageLoader

@MainActor
class ImageLoader: ObservableObject, ImageLoaderProtocol {
    
    enum ImageType {
        case thumbnail
        case poster
    }
    
    @Published var image: UIImage?
    
    private var urlString: String?
    
    private var url: URL?
    
    private var persistentStoreManager: PersistentStoreManagerProtocol
    
    private let networkingManager: NetworkingManagerProtocol
    
    init(persistentStoreManager: PersistentStoreManagerProtocol, networkingManager: NetworkingManagerProtocol) {
        self.persistentStoreManager = persistentStoreManager
        self.networkingManager = networkingManager
    }
    
    func set(urlString: String, type: ImageType) async throws {
        do {
            self.urlString = urlString
            
            populateURL(type)
            
            try await loadImage()
        } catch {
            throw error
        }
    }
    
    func populateURL(_ type: ImageLoader.ImageType) {
        switch type {
        case .poster:
            self.url = ImagesEndpoint.getPosterImage(self.urlString ?? "").url
        case .thumbnail:
            self.url = ImagesEndpoint.getThumbnail(self.urlString ?? "").url
        }
    }
    
    func loadImage() async throws {
        do {
            if let data = await persistentStoreManager.getObject(urlString ?? "", Data.self) {
                self.image = UIImage(data: data)
                return
            }
            
            guard let url = self.url else { return }
            
            let data = try await networkingManager.request(url: url, session: .shared, type: Data.self)
            
            if let image = UIImage(data: data) {
                
                await persistentStoreManager.setObject(urlString ?? "", value: data)
                
                self.image = image
                
                Logger.logInfo(Self.self, "Fetched image: \(image) from network and saved it in persistent store")
            }
        } catch {
            throw error
        }
    }
}
