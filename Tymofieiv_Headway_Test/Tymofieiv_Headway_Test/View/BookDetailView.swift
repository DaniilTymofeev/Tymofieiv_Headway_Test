//
//  BookDetailView.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import SwiftUI

struct BookDetailView: View {
//    let book: Book
//    @ObservedObject var viewModel: BookViewModel
    @State var isShownTextSummary: Bool = false
    @State var slider: Float = 30
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: 200, height: 300)
                }
                .foregroundStyle(.yellow)
                .frame(height: geo.size.height/2 + geo.safeAreaInsets.top)
                VStack(spacing: 10) {
                    Text("Key point 3 of 6".uppercased())
                        .bold()
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    Text("Visualize and exercise")
                    HStack {
                        Text("00:01")
                        Slider(value: $slider, in: 0...100)
                        Text("12:30")
                    }
                    .padding()
                
                    Button(action: {}) {
                        Text("Butt")
                    }
                    Spacer()
                    HStack(spacing: 40) {
                        Button(action: {}) {
                            Image(systemName: "play")
                        }
                        Button(action: {}) {
                            Image(systemName: "play")
                        }
                        Button(action: {audioPlayerViewModel.playOrPause()}) {
                            Image(systemName: "play")
                        }
                        Button(action: {}) {
                            Image(systemName: "play")
                        }
                        Button(action: {}) {
                            Image(systemName: "play")
                        }
                    }
                    .background(.yellow)
                    Spacer()
                    Toggle(isOn: $isShownTextSummary){}
                        .frame(width: 40, height: 40, alignment: .center)
                }
            }
            

//            HStack {
//                Button(action: {
//                    viewModel.seekBackward()
//                }) {
//                    Image(systemName: "gobackward.5")
//                }
//
//                Button(action: {
//                    if viewModel.isPlaying {
//                        viewModel.pauseAudio()
//                    } else {
//                        viewModel.playAudio(for: book)
//                    }
//                }) {
//                    Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
//                }
//
//                Button(action: {
//                    viewModel.seekForward()
//                }) {
//                    Image(systemName: "goforward.10")
//                }
//            }
//            .font(.largeTitle)
        }
        .navigationTitle("book.title")
        .onDisappear {
//            viewModel.stopAudio()
        }
    }
}

#Preview {
    BookDetailView()
}
