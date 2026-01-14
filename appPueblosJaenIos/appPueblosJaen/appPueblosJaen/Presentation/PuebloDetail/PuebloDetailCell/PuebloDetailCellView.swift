//
//  PuebloDetailCellView.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 13/1/26.
//

import SwiftUI

struct PuebloDetailCellView: View {
    
    // MARK: Properties
    let foto: PuebloFoto
    
    // MARK: Init
    init(foto: PuebloFoto) {
        self.foto = foto
    }
    
    private var fotoUrl: URL? {
        URL(string: (foto.url_foto).trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    var body: some View {
        VStack {
            if let url = fotoUrl {
                AsyncImage(url: url) { phase in
                    switch phase {
                        
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 320, height: 180)
                            ProgressView()
                        }
                        
                    case .success(let foto):
                        foto
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .accessibilityLabel(Text("Foto de Pueblo"))
                        
                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 320, height: 180)
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityLabel("Foto no disponible")
                        
                    @unknown default:
                        Color.clear
                            .frame(width: 320, height: 180)
                    }
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.secondary.opacity(0.08))
                        .frame(width: 320, height: 180)
                    Image(systemName: "photo")
                        .imageScale(.large)
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel("Foto no disponible")
            }
        }
    }
}

#Preview {
    PuebloDetailCellView(foto: PuebloFoto(id: 8, lugar_id: 6, url_foto: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/fotos-lugares/lugares/17/1768416677749_0.jpeg", titulo: "Ermita de San Francisco", descripcion: "", es_portada: true, orden: 0, created_at: nil))
}
