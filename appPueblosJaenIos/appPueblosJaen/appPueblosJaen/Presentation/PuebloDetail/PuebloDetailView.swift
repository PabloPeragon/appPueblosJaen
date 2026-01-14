//
//  PuebloDetailView.swift
//  appPueblosJaen
//
//  Created by Pablo Peragón Garrido on 5/12/25.
//

import SwiftUI
import MapKit

struct PuebloDetailView: View {
    
    //MARK: - Properties
    @ObservedObject var homeViewModel: HomeViewModel
    var pueblo: Pueblo
    @State private var cameraPosition: MapCameraPosition
    @StateObject private var detailViewModel: PuebloDetailViewModel
    private let showPhotosInPreview: Bool
    private let previewFotos: [PuebloFoto]?
    
    //MARK: - Computed display strings
    private var habitantesText: String {
        pueblo.habitantes?.formatted() ?? "No disponibles"
    }
    
    private var altitudText: String {
        if let altitud = pueblo.altitud {
            return "\(altitud) m"
        }
        return "No disponible"
    }
    
    private var comarcaText: String {
        pueblo.comarca ?? "No disponible"
    }
    
    private var descripcionText: String {
        pueblo.descripcion ?? "No hay descripción disponible para este pueblo."
    }
    
    //MARK: - Init
    init(homeViewModel: HomeViewModel, pueblo: Pueblo, showPhotosInPreview: Bool = false, previewFotos: [PuebloFoto]? = nil) {
        self.homeViewModel = homeViewModel
        self.pueblo = pueblo
        let latitud = pueblo.latitud ?? 0
        let longitud = pueblo.longitud ?? 0
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitud, longitude: longitud),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        _cameraPosition = State(initialValue: .region(region))
        _detailViewModel = StateObject(wrappedValue: PuebloDetailViewModel(repository: homeViewModel.repository))
        self.showPhotosInPreview = showPhotosInPreview
        self.previewFotos = previewFotos
    }
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                mapSection
                titleSection
                statsSection
                descriptionSection
                if showPhotosInPreview { photosSection }
            }
            .padding(.horizontal)
        }
        .navigationTitle(pueblo.nombre)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.purple, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        // Cargo el id del pueblo seleccionado
        .task(id: pueblo.id) {
            await detailViewModel.load(for: pueblo.id)
        }
    }
    
    //MARK: - View Components
    private var mapSection: some View {
        Map(position: $cameraPosition) {
            let latitud = pueblo.latitud ?? 0
            let longitud = pueblo.longitud ?? 0
            Annotation(pueblo.nombre, coordinate: CLLocationCoordinate2D(latitude: latitud, longitude: longitud)) {
                ZStack {
                    Circle()
                        .fill(.purple)
                        .frame(width: 18, height: 18)
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var titleSection: some View {
        Text(pueblo.nombre)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.purple)
    }
    
    private var statsSection: some View {
        HStack(spacing: 4) {
            InfoCard(
                icon: "person.2.circle",
                title: "Habitantes",
                value: habitantesText
            )
            
            InfoCard(
                icon: "mountain.2.circle",
                title: "Altitud",
                value: altitudText
            )
            
            InfoCard(
                icon: "location.circle",
                title: "Comarca",
                value: comarcaText
            )
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Descripción", systemImage: "text.alignleft")
                .font(.headline)
                .foregroundStyle(.purple)
            
            Text(descripcionText)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.secondary.opacity(0.08))
        )
    }
    
    @ViewBuilder
    private var photosSection: some View {
        let source = previewFotos ?? detailViewModel.fotosPueblo
        let photos = source.sorted { ($0.orden ?? Int.max) < ($1.orden ?? Int.max) }
        
        
        if !photos.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(photos) { foto in
                        PuebloDetailCellView(foto: foto)
                    }
                }
                .padding(.horizontal)
                
            }
        }
    }
}

//MARK: - InfoCard Component
struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Label(title, systemImage: icon)
                .font(.caption2)
                .foregroundStyle(.purple)
            
            Text(value)
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.secondary.opacity(0.08))
        )
    }
}

//MARK: - Preview
#Preview {
    NavigationStack {
        PuebloDetailView(
            homeViewModel: HomeViewModel(
                repository: RepositoryImpl(
                    remoteDataSource: RemoteDataSourceImpl()
                )
            ),
            pueblo: Pueblo(
                id: 204,
                nombre: "Jamilena",
                codigo_postal: "23658",
                habitantes: 3412,
                latitud: 37.75000000,
                longitud: -3.93330000,
                comarca: "Jaén",
                descripcion: "Jamilena es el municipio con el término municipal más pequeño de toda la provincia. Su reducido término municipal se divide en dos mitades: una serrana, dedicada a pastos, y otra ocupada por olivar. El otro gran producto de Jamilena, el ajo, aunque la conservación, manipulación, envasado y comercialización se realiza en la propia localidad y constituye una de las ocupaciones principales.",
                url_escudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png",
                altitud: 568,
                superficie: 0.0,
                gentilicio: "Jamilenuo"
            ),
            showPhotosInPreview: true,
            previewFotos: [
                // Inserta aquí tus PuebloFoto con orden y url_foto
                PuebloFoto(id: 8, lugar_id: 6, url_foto: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/fotos-lugares/lugares/6/1765971791759_0.jpg", titulo: "Ermita de San Francisco", descripcion: "", es_portada: true, orden: 0, created_at: nil),
                PuebloFoto(id: 10, lugar_id: 11, url_foto: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/fotos-lugares/lugares/11/1766051675274_0.jpg", titulo: "Fuente", descripcion: "", es_portada: false, orden: 1, created_at: nil),
                PuebloFoto(id: 11, lugar_id: 12, url_foto: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/fotos-lugares/lugares/12/1766052085635_0.jpg", titulo: "Fuente", descripcion: "", es_portada: false, orden: 2, created_at: nil)
            ]
        )
    }
}
