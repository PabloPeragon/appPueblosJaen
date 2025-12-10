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
        if let habitantes = pueblo.habitantes {
            return habitantes.formatted()
        } else {
            return "No disponibles"
        }
    }
    
    private var altitudText: String {
        if let altitud = pueblo.altitud {
            return "\(altitud) m"
        } else {
            return "No disponible"
        }
    }
    
    private var comarcaText: String {
        if let comarca = pueblo.comarca {
            return comarca
        } else {
            return "No disponible"
        }
    }
    
    
    
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
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16) {
                Map(position: $cameraPosition) {
                    let latitud = pueblo.latitud ?? 0
                    let longitud = pueblo.longitud ?? 0
                    Annotation(pueblo.nombre, coordinate: CLLocationCoordinate2D(latitude: latitud, longitude: longitud)) {
                        ZStack {
                            Circle().fill(.purple).frame(width: 18, height: 18)
                            Circle().stroke(.white, lineWidth: 2).frame(width: 12, height: 12)
                        }
                    }
                }
                
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            Text(pueblo.nombre)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
            
            HStack(spacing: 12) {
                //Habitantes
                VStack(alignment: .leading, spacing: 4) {
                    Label("Habitantes", systemImage: "person.2.circle")
                        .font(.caption)
                        .foregroundStyle(.purple)
                    Text(habitantesText)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.secondary.opacity(0.08))
                )
                
                //Altitud
                VStack(alignment: .leading, spacing: 4) {
                    Label("Altitud", systemImage: "mountain.2.circle")
                        .font(.caption)
                        .foregroundStyle(.purple)
                    Text(altitudText)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.secondary.opacity(0.08))
                )
                
                // Provincia
                VStack(alignment: .leading, spacing: 4) {
                    Label("Comarca", systemImage: "location.circle")
                        .font(.caption)
                        .foregroundStyle(.purple)
                    Text(comarcaText)
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
        .navigationTitle(pueblo.nombre)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.purple, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        //.tint(.white)
    }
        
}

#Preview {
    PuebloDetailView(homeViewModel: HomeViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())), pueblo: Pueblo(id: 204, nombre: "Jamilena", codigo_postal: "23658", habitantes: 3412, latitud: 37.75000000, longitud: -3.93330000, comarca: "Jaén", descripcion: "Pueblo con importante producción de aceite de oliva y conservación, manipulación, envasado y comercialización del ajo.", url_escudo: "https://kmxacmsqybtwbebqhwnu.supabase.co/storage/v1/object/public/escudos-pueblos/escudos/204.png", altitud: 568, superficie: 0.0, gentilicio: "Jamilenuo"))
}
