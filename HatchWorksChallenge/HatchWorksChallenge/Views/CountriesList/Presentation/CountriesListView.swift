//
//  CountriesListView.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct CountriesListView: View {
    @State private var viewmodel: CountriesListViewModel

    init(viewmodel: CountriesListViewModel) {
        self._viewmodel = State(wrappedValue: viewmodel)
    }

    var body: some View {
        NavigationStack {
            mainUI
                .navigationTitle(EntryViewModel.Tabs.countries.title)
                .task {
                    await viewmodel.getCountries()
                }
        }
    }

    @ViewBuilder
    private var mainUI: some View {
        switch viewmodel.screenState {
        case .loading:
            ProgressView()
        case .loaded:
            CountryListViewComponent(countries: viewmodel.allCountries)
        case .error:
            ContentUnavailableView {
                Label("Error while loading", systemImage: "wifi.exclamationmark")
            } description: {
                Text("We were unable to load the content, please try again!")
            } actions: {
                Button {
                    Task {
                        await viewmodel.getCountries()
                    }
                } label: {
                    Text("Try Again")
                }
            }
        }
    }
}

#Preview {
    CountriesListView(
        viewmodel: CountriesListViewModel(
            getCountriesUseCase: GetCountriesUseCase()
        )
    )
}
