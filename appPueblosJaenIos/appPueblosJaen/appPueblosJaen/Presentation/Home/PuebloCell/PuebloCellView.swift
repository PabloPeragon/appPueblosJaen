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
    
    private var escudoURL: URL? {
        URL(string: (pueblo.urlEscudo ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
    }

    private var nombreSeguro: String {
        let trimmed = pueblo.nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Nombre no disponible" : trimmed
    }
    
    var body: some View {
        HStack {
            if let url = escudoURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 100, height: 50)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 50)
                            .accessibilityLabel("Escudo de \(nombreSeguro)")
                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 100, height: 50)
                            Image(systemName: "shield.lefthalf.filled")
                                .imageScale(.large)
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityLabel("Escudo no disponible")
                    @unknown default:
                        Color.clear
                            .frame(width: 100, height: 50)
                    }
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.secondary.opacity(0.08))
                        .frame(width: 100, height: 50)
                    Image(systemName: "shield.lefthalf.filled")
                        .imageScale(.large)
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel("Escudo no disponible")
            }
            
            Text(nombreSeguro)
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundStyle(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
                .accessibilityLabel("Nombre del pueblo: \(nombreSeguro)")
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
