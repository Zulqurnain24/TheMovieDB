//
//  MovieImageView.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 16/11/2023.
//

import SwiftUI

struct MovieImageView: View {

    var imageUrl: URL?
    var imageLoader: ImageLoader
    var imageHeight: CGFloat
    var imageWidth: CGFloat
    var cornerRadius: CGFloat

    var body: some View {
        if let url = imageUrl {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .fixedSize()
                    .frame(maxHeight: imageHeight)
                    .frame(maxWidth: imageWidth)
                    .cornerRadius(cornerRadius)
            } else {
                AsyncImage(url: url) { image in
                    image.resizable(resizingMode: .tile)
                } placeholder: {
                    ProgressView()
                }
                .fixedSize()
                .frame(maxHeight: imageHeight)
                .frame(maxWidth: imageWidth)
                .cornerRadius(cornerRadius)
            }
        }
    }
}

extension MovieImageView: Equatable {
    static func == (lhs: MovieImageView, rhs: MovieImageView) -> Bool {
        lhs.imageUrl == rhs.imageUrl
        &&
        lhs.imageWidth == rhs.imageWidth
        &&
        lhs.imageHeight == rhs.imageHeight
        &&
        lhs.cornerRadius == rhs.cornerRadius
    }
}

#Preview {
    TMDBFactory.createMovieImageViewMock()
}
