//
//  ContentView.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
//    @StateObject private var viewModel = BookViewModel()
//    let store = Store(reducer: appReducer, state: AppState())
    
    
    var body: some View {
//        NavigationView {
//            NavigationLink(destination: BookDetailView(
//                store: Store(initialState: BookDetails.State()) {
//                    BookDetails()
//                }))
//            {
//                Text("dsdsdsd")
//            }
//        }
        
        SharedAudioPlayerView()
    }
}

#Preview {
    ContentView()
}
