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
            List {
                ForEach(viewmodel.filteredCountries) { country in
                    NavigationLink {
                        CountryDetailView(
                            viewModel: CountryDetailViewModel(
                                tappedCountry: country,
                                getCountryDetailUseCase: GetCountryDetailUseCase()
                            )
                        )
                    } label: {
                        countryCell(for: country)
                    }
                }
            }
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

    @ViewBuilder
    private func countryCell(for country: Country) -> some View {
        HStack(spacing: 12.0) {
            AsyncImage(url: country.flagURL) { image in
                image
                    .resizable()
                    .frame(width: 44, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.separator, lineWidth: 0.5)
                    )
            } placeholder: {
                ProgressView()
            }
            .frame(width: 44, height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(country.name)
                    .font(.headline)
                    .lineLimit(1)

                Text("Population: \(country.population.formatted(.number.grouping(.automatic)))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
    }
}

#Preview {
    CountriesListView(
        viewmodel: CountriesListViewModel(
            getCountriesUseCase: GetCountriesUseCase()
        )
    )
}
