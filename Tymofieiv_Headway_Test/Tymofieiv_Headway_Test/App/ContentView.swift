//
//  ContentView.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import ComposableArchitecture
import SwiftUI
import AVFAudio

struct ContentView: View {
    let store: Store = .init(
        initialState: SharedAudioPlayerReducer.State(
            avAudioPlayer: Shared.init(
                wrappedValue: AVAudioPlayer(),
                .inMemory("audio")
            ), currentBook: AtomicHabits
        )
    ) {
        SharedAudioPlayerReducer()
    }
    
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: SharedAudioPlayerView(store: store)) {
                AsyncImage(
                    url: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_cover", ofType: "jpeg") ?? "ERROR"),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaleEffect(0.5)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .gray, radius: 1, x: 5, y: 5)
            }
            .frame(width: .infinity, height: .infinity)
            .background(Color("BackgroundColor", bundle: .main))
        }
    }
    
}

#Preview {
    ContentView()
}
