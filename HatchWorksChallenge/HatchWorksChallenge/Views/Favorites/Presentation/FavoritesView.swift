//
//  FavoritesView.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct FavoritesView: View {

    @State private var viewModel: FavoritesViewModel

    init(viewModel: FavoritesViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            mainUI
                .navigationTitle(EntryViewModel.Tabs.favorites.title)
                .onAppear {
                    viewModel.getFavoriteCountries()
                }
        }
    }

    @ViewBuilder
    private var mainUI: some View {
        switch viewModel.screenState {
        case .loading:
            ProgressView()
        case .loaded:
            CountryListViewComponent(countries: viewModel.countries)
        case .noFavorites:
            ContentUnavailableView {
                Label("No Favorites Yet", systemImage: "star")
            } description: {
                Text("You haven't added any countries to your favorites.")
            }
        }
    }
}

#Preview {
    FavoritesView(
        viewModel: FavoritesViewModel(
            getFavorites: GetFavoritesUseCase()
        )
    )
}
