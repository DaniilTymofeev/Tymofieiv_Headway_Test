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
    @State var keyStartTime: Int = 0
    @State var audionDurationTimeStamp: Int = 360
    @State var currentKeyPointId: Int = 0
    @State var currentSpeed: PlaybackSpeed = .normal
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    func timeIntervalFormmater(_ timeInSeconds: Int) -> String {
        "will see"
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    AsyncImage(
                        url: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_cover", ofType: "jpeg") ?? "ERROR"),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(idealWidth: geo.size.width*0.55, idealHeight: geo.size.height*0.45)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .gray, radius: 1, x: 5, y: 5)
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
                        Text("00:00")
                        Slider(value: $slider, in: 0...100)
                        Text("12:30")
                    }
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding()
                
                    Button(action: {
                        currentSpeed = playbackSpeedSwitch(currentSpeed)
                    }) {
                        Text("\(currentSpeed.rawValue) speed")
                            .transaction { $0.animation = nil }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .background(Color.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .foregroundStyle(.white)
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
