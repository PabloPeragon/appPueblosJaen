//
//  HomeView.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 16/11/25.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var searchText: String = ""
    
    //MARK: - Functions
    private var filteredPueblos: [Pueblo] {
        let rawQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let query = rawQuery.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        guard !query.isEmpty else { return homeViewModel.pueblos }
        return homeViewModel.pueblos.filter { pueblo in
            let normalizedName = pueblo.nombre
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            return normalizedName.contains(query)
        }
    }
    
    var body: some View {
        NavigationView{
            List(filteredPueblos) { pueblo in
                PuebloCellView(pueblo: pueblo)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar pueblos")
            .navigationTitle("Pueblos de Jaén")
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.purple, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .tint(.white)
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())))
}
