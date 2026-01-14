//
//  EntryView.swift
//  HatchWorksChallenge
//
//  Created by Kevin Solano Jiménez on 13/1/26.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        TabView {
            ForEach(EntryViewModel.Tabs.allCases, id: \.self) { tab in
                Tab(tab.title, systemImage: tab.image) {
                    tab.view
                }
            }
        }
    }
}

#Preview {
    EntryView()
}
