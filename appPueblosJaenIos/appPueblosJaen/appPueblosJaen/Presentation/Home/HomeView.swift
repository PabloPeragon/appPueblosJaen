//
//  HomeView.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 16/11/25.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    var pueblos: [Pueblo] = []
    
    //MARK: - Functions
    init(pueblos: [Pueblo]) {
        for i in 1...10{
            let pueblo = Pueblo(id: 204, nombre: "Jamilena\(i)", codigoPostal: "23658", habitantes: 3412, latitud: 37.75000000, longitud: -3.93330000, comarca: "Jaén", descripcion: "Tierra de ajo y aceite de oliva, pueblo pequeño pero muy bonito, Jamilena chiquita y bonita.", urlEscudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png", altitud: 568, superficie: 10.0, gentilicio: "Jamilenudo"
            )
            self.pueblos.append(pueblo)
        }
    }
    
    var body: some View {
        NavigationView{
            List(self.pueblos) { pueblo in
                PuebloCellView(pueblo: pueblo)
            }
            .navigationTitle("Pueblos")
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView(pueblos: [])
}
