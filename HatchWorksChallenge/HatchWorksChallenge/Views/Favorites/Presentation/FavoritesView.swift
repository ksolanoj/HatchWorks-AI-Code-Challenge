//
//  FavoritesView.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle(EntryViewModel.Tabs.favorites.title)
        }
    }
}

#Preview {
    FavoritesView()
}
