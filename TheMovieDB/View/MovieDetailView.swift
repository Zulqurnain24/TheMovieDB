//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

protocol MovieDetailViewProtocol: View {
    func updateImageLoader() async throws
}

// MARK: - MovieDetailView

struct MovieDetailView<ViewModel: MovieDetailViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State private var size: CGSize = .zero
    var imageLoader: ImageLoader
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    Spacer()
                    
                    Text(viewModel.movie.title)
                        .font(.title)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .accessibilityIdentifier("movieTitleText")
                    
                    MovieImageView(imageUrl: ImagesEndpoint.getPosterImage(viewModel.movieDetails?.posterPath ?? "").url, imageLoader: TMDBFactory.createImageLoader(), imageHeight: Constants.detailViewImageHeight, imageWidth: .infinity, cornerRadius: Constants.cornerRadius)
                    
                    Text(Constants.detailViewOverviewTitle)
                        .font(.headline)
                        .accessibilityIdentifier("overviewLabelText")
                    
                    Text(viewModel.movieDetails?.overview ?? "")
                        .font(.body)
                        .accessibilityIdentifier("overviewValueText")
                    
                    Spacer()
                    
                    Text("\(Constants.ratingLabel) \(String(format: "%.1f", viewModel.movie.voteAverage))")
                        .font(.headline)
                        .accessibilityIdentifier("ratingText")
                    
                    Spacer()
                    
                    if let url = URL(string: viewModel.movieDetails?.homepage ?? "") {
                        Link(Constants.detailViewVistHomeButtonTitle, destination: url)
                            .accessibilityIdentifier("visitHomepageLink")
                    }
                    
                }
                .padding(.vertical, geometry.size.height * Constants.detailViewVStackVerticalPaddingPercentageWithRespectToGeometry)
                .padding(.horizontal, geometry.size.width * Constants.detailViewVStackHorizontalPaddingPercentageWithRespectToGeometry)
            }
            .scrollIndicators(.hidden, axes: [.horizontal, .vertical])
            .ignoresSafeArea()
            .onAppear {
                Task {
                    size = geometry.size
                    await viewModel.fetchMovieDetails()
                    try await updateImageLoader()
                }
            }
        }
    }
    
    func updateImageLoader() async throws {
        try await self.imageLoader.set(urlString: viewModel.movieDetails?.posterPath ?? "", type: .poster)
    }
}

#Preview {
    TMDBFactory.createMovieDetailViewMock()
}
