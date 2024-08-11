//
//  ContentView.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BookViewModel()
    
    var body: some View {
        NavigationView {
//            List(viewModel.books) { book in
//                NavigationLink(destination: BookDetailView()) {
//                    Text(book.title)
//                }
//            }
            BookDetailView()
            .navigationTitle("Book Summaries")
        }
    }
}

#Preview {
    ContentView()
}
