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
    init(homeViewModel: HomeViewModel, pueblo: Pueblo) {
        self.homeViewModel = homeViewModel
        self.pueblo = pueblo
        let latitud = pueblo.latitud ?? 0
        let longitud = pueblo.longitud ?? 0
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitud, longitude: longitud),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        _cameraPosition = State(initialValue: .region(region))
    }
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                mapSection
                titleSection
                statsSection
                descriptionSection
            }
            .padding(.horizontal)
        }
        .navigationTitle(pueblo.nombre)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.purple, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
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
                descripcion: "Pueblo con importante producción de aceite de oliva y conservación, manipulación, envasado y comercialización del ajo.",
                url_escudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png",
                altitud: 568,
                superficie: 0.0,
                gentilicio: "Jamilenuo"
            )
        )
    }
}
