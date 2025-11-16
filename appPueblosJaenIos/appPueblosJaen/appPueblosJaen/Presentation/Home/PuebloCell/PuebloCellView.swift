//
//  PuebloCellView.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 14/11/25.
//

import SwiftUI

struct PuebloCellView: View {
    
    var pueblo: Pueblo
    
    init(pueblo: Pueblo) {
        self.pueblo = pueblo
    }
    
    var body: some View {
        HStack {
            // Imagen del escudo
            AsyncImage(url: URL(string: pueblo.urlEscudo), content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 50)
            }, placeholder: {
                ZStack {
                    Color.clear
                        .frame(width: 100, height: 50)
                    ProgressView()
                }
            })
            
            //nombre del pueblo
            Text(pueblo.nombre)
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    PuebloCellView(pueblo:
            Pueblo(
                id: 204, nombre: "Jamilena", codigoPostal: "23658", habitantes: 3412, latitud: 37.75000000, longitud: -3.93330000, comarca: "Jaén", descripcion: "Tierra de ajo y aceite de oliva, pueblo pequeño pero muy bonito, Jamilena chiquita y bonita.", urlEscudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png", altitud: 568, superficie: 10.0, gentilicio: "Jamilenudo"
                          )
    )
}


