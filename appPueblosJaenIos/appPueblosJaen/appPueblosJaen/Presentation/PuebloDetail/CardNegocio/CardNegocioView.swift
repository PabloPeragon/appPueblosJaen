//
//  CardNegocioView.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 18/2/26.
//

import SwiftUI

struct CardNegocioView: View {
    // MARK: Properties
    let negocio: Negocio
    
    // MARK: Init
    init(negocio: Negocio) {
        self.negocio = negocio
    }
    
    private var imagenPrinUrl: URL? {
        URL(string: (negocio.imagen_principal_url).trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    
    var body: some View {
        VStack {
            if let url = imagenPrinUrl {
                AsyncImage(url: url) { phase in
                    switch phase {
                        
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 320, height: 180)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 290)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .accessibilityLabel(Text("Imagen del negocio"))
                        
                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color.secondary.opacity(0.08))
                                .frame(width: 320, height: 180)
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityLabel("Imagen no disponible")
                        
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
                .accessibilityLabel("Imagen no disponible")
                
            }
        }
    }
}

#Preview {
    CardNegocioView(negocio: Negocio(id: 01, pueblo_id: 49, categoria_id: 2, nombre: "Desarrollos iOS app Peragón Liébana ", descripcion: "Creación de apps iOS", descripcion_corta: "App iOS", direccion: "Glorieta de San Isidro nº1", telefono: "953 000 000", movil: "662 47 34 91", email: "pabloperagon@gmail.com", web: "www.ios.com", instagram: "", facebook: "", twitter: "", latitud: nil, longitud: nil, horario: nil, es_premium: nil, fecha_inicio_premium: nil, fecha_fin_premium: nil, orden_destacado: 2, visualizaciones: nil, activo: nil, verificado: nil, fecha_verificacion: nil, propietario_email: nil, propietario_nombre: "", created_at: "", updated_at: "", notificacion_pdf_url: "", imagen_principal_url: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/imagenes-negocios/negocios/4/logo_1771413152127.jpg"))
}
