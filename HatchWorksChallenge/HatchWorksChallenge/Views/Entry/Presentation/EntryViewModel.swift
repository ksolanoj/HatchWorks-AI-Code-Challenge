//
//  EntryViewModel.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

final class EntryViewModel {
    
    /// Enum with the Tabs used on the EntryView
    enum Tabs: CaseIterable, Hashable {
        case countries
        case favorites

        /// Title for the corresponding Tab
        var title: LocalizedStringKey {
            switch self {
            case .countries:
                return "Countries"
            case .favorites:
                return "Favorites"
            }
        }

        /// Image for the corresponding Tab
        var image: String {
            switch self {
            case .countries:
                return "globe.americas.fill"
            case .favorites:
                return "star.fill"
            }
        }
        
        /// View associated witht the Tab
        @ViewBuilder
        var view: some View {
            switch self {
            case .countries:
                CountriesListView(
                    viewmodel: CountriesListViewModel(
                        getCountriesUseCase: GetCountriesUseCase()
                    )
                )
            case .favorites:
                FavoritesView()
            }
        }
    }
}
