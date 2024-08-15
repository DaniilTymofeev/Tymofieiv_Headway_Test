//
//  BookDetailView.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import ComposableArchitecture
import SwiftUI
import AVFAudio

@Reducer
struct BookDetails: Reducer {
    
    @ObservableState
    struct State {
        var currentBook: Book? = AtomicHabits
        var isPlaying: Bool = false
        var keyPointDuration: Int = 0
        var currentKeyPoint: Int = 0
        var currentTime: Float = 0
        var currentSpeedPlayback: PlaybackSpeed = .normal
    }
    
    enum Action {
        case fetchBook(Book)
        case playPauseAudio(Float)
        case switchKeyPoint(KeyPointSwitchDirection)
        case switchSpeedPlayback
        case seekForward(Float)
        case seekBackward(Float)
        case setSliderCurrentTime(Float)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
          switch action {
          case .fetchBook(let book):
              state.currentBook = book
              return .none
          case .playPauseAudio(let time):
              state.isPlaying.toggle()
              state.currentTime = time
              return .none
          case .switchKeyPoint(let direction):
              state.currentKeyPoint = keyPointSwitch(book: state.currentBook, currentKeyPoint: state.currentKeyPoint, direction: direction)
              return .none
          case .switchSpeedPlayback:
              state.currentSpeedPlayback = playbackSpeedSwitch(state.currentSpeedPlayback)
              return .none
          case .seekForward(let plus):
              state.currentTime += plus
              return .none
          case .seekBackward(let minus):
              state.currentTime -= minus
              return .none
          case .setSliderCurrentTime(let time):
              state.currentTime = time
              return .none
          }
        }
      }
}

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
    
    @Bindable var store: StoreOf<BookDetails>
    
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
                    Text("Key point \(store.currentKeyPoint + 1) of \(store.currentBook?.chapters.count ?? 0)".uppercased())
                        .bold()
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    Text(store.currentBook?.chapters[store.currentKeyPoint].name ?? "error")
                        .foregroundStyle(.white)
                    
                    HStack {
                        Text("\(store.currentTime)")
                        Slider(value: $store.currentTime.sending(\.setSliderCurrentTime), in: 0...100)
                        Text("20")
                    }
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding()
                
                    Button(action: {
//                        currentSpeed = playbackSpeedSwitch(currentSpeed)
                        store.send(.switchSpeedPlayback)
                    }) {
                        Text("\(store.currentSpeedPlayback.rawValue) speed")
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
                        Button(action: {
                            store.send(.switchKeyPoint(.backward))
                        }) {
                            Image(systemName: "backward.end.fill")
                        }
                        .font(.title2)
                        
                        Button(action: {
                            store.send(.seekBackward(5))
                        }) {
                            Image(systemName: "gobackward.5")
                        }
                        .font(.title)
                        
                        Button(action: {
                            store.send(.playPauseAudio(audioPlayerViewModel.currentTime))
                            audioPlayerViewModel.playOrPause(at: store.currentTime)
                        }) {
                            Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        Button(action: {
                            store.send(.seekForward(10))
                        }) {
                            Image(systemName: "goforward.10")
                        }
                        .font(.title)
                        
                        Button(action: {
                            store.send(.switchKeyPoint(.forward))
                        }) {
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
        .onAppear {
            store.send(.fetchBook(AtomicHabits))
        }
    }
}

#Preview {
    BookDetailView(
        store: Store(initialState: BookDetails.State()) {
            BookDetails()
        }
    )
}
