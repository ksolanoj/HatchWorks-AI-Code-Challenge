//
//  CountryListViewComponent.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct CountryListViewComponent: View {
    let countries: [Country]

    var body: some View {
        List {
            ForEach(countries) { country in
                NavigationLink {
                    CountryDetailView(
                        viewModel: CountryDetailViewModel(
                            tappedCountry: country,
                            getCountryDetailUseCase: GetCountryDetailUseCase(),
                            addToFavoritesUseCase: AddToFavoritesUseCase(),
                            removeFromFavoritesUseCase: RemoveFromFavoritesUseCase(),
                            isFavoriteUseCase: IsFavoriteUseCase()
                        )
                    )
                } label: {
                    countryCell(for: country)
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
    CountryListViewComponent(countries: [])
}
