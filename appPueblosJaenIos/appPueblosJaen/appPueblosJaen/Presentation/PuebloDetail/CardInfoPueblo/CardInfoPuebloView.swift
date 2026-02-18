//
//  CardInfoPuebloView.swift
//  appPueblosJaen
//
//  Created by Pablo Jesús Peragón Garrido on 14/2/26.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true // Para que el PDF se ajuste al ancho de la pantalla
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // No necesitamos actualizar nada dinámicamente por ahora
    }
}

struct CardInfoPuebloView: View {
    var negocio: Negocio
    @State private var isShowingDetail = false
    
    var body: some View {
        Button(action: {
            isShowingDetail = true
        }) {
            VStack(alignment: .leading, spacing: 0) {
                // Parte superior: Miniatura del PDF
                if let urlString = negocio.notificacion_pdf_url, let url = URL(string: urlString) {
                    PDFKitView(url: url)
                        .frame(height: 200) // Altura fija para la parte visual
                        .disabled(true) // Evita que el usuario haga scroll dentro de la miniatura
                        
                }
                
                // Parte inferior: Título y detalles
                VStack(alignment: .leading, spacing: 4) {
                    if let texto = negocio.descripcion_corta?.trimmingCharacters(in: .whitespacesAndNewlines), !texto.isEmpty {
                        Text(texto)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundStyle(.primary)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
            }
        }
        .frame(width: 140) // Ancho rectangular contenido
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .fullScreenCover(isPresented: $isShowingDetail) {
            PDFDetailReader(negocio: negocio)
        }
    }
}

struct PDFDetailReader: View {
    let negocio: Negocio
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Group {
                if let urlString = negocio.notificacion_pdf_url, let url = URL(string: urlString) {
                    PDFKitView(url: url)
                        .ignoresSafeArea(edges: .bottom)
                        // Añadimos el ShareLink en la toolbar
                        .toolbar {
                            // Botón de Cerrar a la izquierda (opcional, según prefieras el orden)
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Cerrar") {
                                    dismiss()
                                }
                            }
                            
                            // Botón de Compartir a la derecha
                            ToolbarItem(placement: .topBarTrailing) {
                                ShareLink(item: url) {
                                    Label("Compartir", systemImage: "square.and.arrow.up")
                                }
                            }
                        }
                } else {
                    Text("Error al cargar el documento")
                }
            }
            .navigationTitle(negocio.nombre)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    CardInfoPuebloView(negocio: Negocio(id: 9, pueblo_id: 42, categoria_id: 3, nombre: "Ayuntamiento de Jamilena", descripcion: "Jamilena", descripcion_corta: "Jamilena", direccion: "", telefono: "", movil: "", email: "", web: "", instagram: "", facebook: "", twitter: "", latitud: nil, longitud: nil, horario: nil, es_premium: false, fecha_inicio_premium: nil, fecha_fin_premium: nil, orden_destacado: 3, visualizaciones: 1, activo: true, verificado: false, fecha_verificacion: "", propietario_email: "", propietario_nombre: "", created_at: "", updated_at: "", notificacion_pdf_url: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/notificaciones-pdfs/notificaciones/3/1771157471599_doc.pdf", imagen_principal_url: ""))
}
