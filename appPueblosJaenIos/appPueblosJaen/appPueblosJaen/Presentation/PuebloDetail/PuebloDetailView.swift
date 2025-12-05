//
//  PuebloDetailView.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 5/12/25.
//

import SwiftUI

struct PuebloDetailView: View {
    //MARK: - Properties
    @ObservedObject var homeViewModel: HomeViewModel
    var pueblo: Pueblo
    
    init(homeViewModel: HomeViewModel, pueblo: Pueblo) {
        self.homeViewModel = homeViewModel
        self.pueblo = pueblo
    }
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PuebloDetailView(homeViewModel: HomeViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())), pueblo: Pueblo(id: 204, nombre: "Jamilena", codigo_postal: "23658", habitantes: 3412, latitud: 37.75000000, longitud: -3.93330000, comarca: "Jaén", descripcion: "Pueblo con importante producción de aceite de oliva y conservación, manipulación, envasado y comercialización del ajo.", url_escudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png", altitud: 568, superficie: 0.0, gentilicio: "Jamilenuo"))
}
