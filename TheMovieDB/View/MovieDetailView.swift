//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Mohammad Zulqurnain on 15/11/2023.
//

import SwiftUI

protocol MovieDetailViewProtocol: View, Equatable {
    func updateImageLoader() async throws
}

// MARK: - MovieDetailView

@MainActor
struct MovieDetailView<ViewModel: MovieDetailViewModelProtocol>: MovieDetailViewProtocol {

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

                    TMDBFactory.createMovieImageView(pathUrl: ImagesEndpoint.getPosterImage(viewModel.movieDetails?.posterPath ?? "").url, imageHeight: Constants.detailViewImageHeight, imageWidth: .infinity, cornerRadius: Constants.cornerRadius)

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
                    do {
                        size = geometry.size
                        await viewModel.fetchMovieDetails()
                        try await updateImageLoader()
                    } catch {
                        Logger.logError(Self.self, error)
                    }
                }
            }
        }
    }

    func updateImageLoader() async throws {
        do {
            try await self.imageLoader.set(urlString: viewModel.movieDetails?.posterPath ?? "", type: .poster)
        } catch {
            Logger.logError(Self.self, error)
        }
    }
}

extension MovieDetailView: Equatable {
    static func == (lhs: MovieDetailView<ViewModel>, rhs: MovieDetailView<ViewModel>) -> Bool {
        lhs.viewModel.movie.id == rhs.viewModel.movie.id
    }
}

#Preview {
    TMDBFactory.createMovieDetailViewMock()
}
