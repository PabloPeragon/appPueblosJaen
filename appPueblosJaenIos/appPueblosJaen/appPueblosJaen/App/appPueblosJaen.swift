//
//  appPueblosJaen.swift
//  pueblosJaen
//
//  Created by Pablo Peragón Garrido on 28/10/25.
//

import SwiftUI

@main
struct appPueblosJaen: App {
    var body: some Scene {
        WindowGroup{
            let remoteDataSource = RemoteDataSourceImpl()
            let repository = RepositoryImpl(remoteDataSource: remoteDataSource)
            RootView()
                //.environment(rootViewModel)
                .environment(RootViewModel(repository: repository))
        }
    }
}





/*
@main
struct appPueblosJaen: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel(repository: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl())))
        }
    }
}
*/
