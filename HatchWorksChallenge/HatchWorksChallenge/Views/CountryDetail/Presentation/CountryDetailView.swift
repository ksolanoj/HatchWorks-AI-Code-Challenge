//
//  CountryDetailView.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct CountryDetailView: View {
    @State private var viewModel: CountryDetailViewModel

    init(viewModel: CountryDetailViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        mainUI
            .navigationTitle(viewModel.tappedCountry.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.getCountryDetail()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.addToFavoritesAction()
                    } label: {
                        Image(systemName: viewModel.addToFavoritesButtonIcon)
                    }
                }
            }
    }

    @ViewBuilder
    private var mainUI: some View {
        switch viewModel.screenState {
        case .loading:
            ProgressView()
        case .error:
            ContentUnavailableView {
                Label("Error while loading", systemImage: "wifi.exclamationmark")
            } description: {
                Text("We were unable to load the content, please try again!")
            } actions: {
                Button {
                    Task {
                        await viewModel.getCountryDetail()
                    }
                } label: {
                    Text("Try Again")
                }
            }
            
        case .loaded:
            if let detail = viewModel.countryDetail {
                getDetailView(detail: detail)
            } else {
                ContentUnavailableView {
                    Label("No Data", systemImage: "exclamationmark.triangle")
                } description: {
                    Text("There is no available data for this country")
                }
            }
        }
    }

    @ViewBuilder
    private func getDetailView(detail: CountryDetail) -> some View {
        List {
            Section {
                HStack(spacing: 12) {
                    AsyncImage(url: detail.flagPNG) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 56, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(detail.name).font(.headline)
                        Text(detail.officialName)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }
            }

            Section("Information") {
                row("Capital", detail.capital ?? "N/A")
                row("Region", detail.region ?? "N/A")
                row("Subregion", detail.subregion ?? "N/A")
                row("Population", "\(detail.population)")
                row("Area", areaText(detail.area))
            }

            if !detail.languages.isEmpty {
                Section("Languages") {
                    ForEach(detail.languages, id: \.self) { lang in
                        Text(lang)
                    }
                }
            }

            if !detail.timezones.isEmpty {
                Section("Timezones") {
                    ForEach(detail.timezones, id: \.self) { tz in
                        Text(tz)
                    }
                }
            }

            if !detail.borders.isEmpty {
                Section("Borders") {
                    ForEach(detail.borders, id: \.self) { border in
                        Text(border)
                    }
                }
            }

            if detail.mapsGoogle != nil || detail.mapsOSM != nil {
                Section("Maps") {
                    if let url = detail.mapsGoogle {
                        Link("Open on Google Maps", destination: url)
                    }
                    if let url = detail.mapsOSM {
                        Link("Open on Street Maps", destination: url)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func row(_ title: LocalizedStringKey, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }

    func areaText(_ area: Double?) -> String {
        guard let area else { return "N/A" }
        return area.formatted(.number.grouping(.automatic)) + " km²"
    }
}

#Preview {
    CountryDetailView(
        viewModel: CountryDetailViewModel(
            tappedCountry: Country(name: "", flagURL: nil, population: 0),
            getCountryDetailUseCase: GetCountryDetailUseCase(),
            addToFavoritesUseCase: AddToFavoritesUseCase(),
            removeFromFavoritesUseCase: RemoveFromFavoritesUseCase(),
            isFavoriteUseCase: IsFavoriteUseCase()
        )
    )
}
