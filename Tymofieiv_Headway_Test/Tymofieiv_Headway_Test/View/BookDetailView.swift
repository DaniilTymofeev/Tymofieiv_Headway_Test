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
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: geo.size.width*0.55, height: geo.size.height*0.45)
                }
                .foregroundStyle(.yellow)
                .frame(height: geo.size.height/2, alignment: .top)
                .padding()
                VStack(spacing: 10) {
                    Text("Key point 3 of 6".uppercased())
                        .bold()
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    Text("Visualize and exercise")
                        .foregroundStyle(.white)
                    HStack {
                        Text("00:01")
                        Slider(value: $slider, in: 0...100)
                        Text("12:30")
                    }
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding()
                
                    Button(action: {}) {
                        Text("1x speed")
                    }
                    .padding(8)
                    .background(Color.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .tint(.white)
                    .font(.system(size: 12, weight: .bold))
                    
                    Spacer()
                    
                    HStack(spacing: 40) {
                        Button(action: {}) {
                            Image(systemName: "backward.end.fill")
                        }
                        .font(.title2)
                        
                        Button(action: {}) {
                            Image(systemName: "gobackward.5")
                        }
                        .font(.title)
                        
                        Button(action: {audioPlayerViewModel.playOrPause()}) {
                            Image(systemName: isShownTextSummary ? "pause.fill" : "play.fill")
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        Button(action: {}) {
                            Image(systemName: "goforward.10")
                        }
                        .font(.title)
                        
                        Button(action: {}) {
                            Image(systemName: "forward.end.fill")
                        }
                        .font(.title2)
                    }
                    .tint(.white)
                    Spacer()
                    Toggle(isOn: $isShownTextSummary){}
                        .frame(width: 40, height: 40, alignment: .center)
                        .tint(.blue)
                }
            }
        }
        .background(Color("BackgroundColor", bundle: .main))
        .navigationTitle("book.title")
        .onDisappear {
//            viewModel.stopAudio()
        }
    }
}

#Preview {
    BookDetailView()
}
