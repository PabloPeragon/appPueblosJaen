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
        HStack{
            // Imagen del escudo
            AsyncImage(url: URL(string: pueblo.urlEscudo!))
            //nombre del pueblo
            Text(pueblo.nombre)
        }
    }
}

#Preview {
    PuebloCellView(pueblo: Pueblo(id: 204, nombre: "Jamilena", codigoPostal: "23658", habitantes: 3412, latitud: 37.75000000, longitud: -3.93330000, comarca: "Jaén", descripcion: "Pueblo con importante producción de aceite de oliva y conservación, manipulación, envasado y comercialización del ajo.", urlEscudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png", altitud: 568, superficie: 0 , gentilicio: "Jamilenuo"))
}
