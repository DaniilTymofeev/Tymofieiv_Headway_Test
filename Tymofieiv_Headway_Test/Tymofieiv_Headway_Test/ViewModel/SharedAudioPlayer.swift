//
//  SharedAudioPlayer.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 15.08.2024.
//

import AVFAudio
import ComposableArchitecture
import Combine
import Foundation
import SwiftUI

extension AVAudioPlayer {
    var progress: Double {
        currentTime / duration
    }
}

@Reducer struct SharedAudioPlayerReducer {
    @ObservableState struct State {
        @Shared var avAudioPlayer: AVAudioPlayer?
        var isPlaying = false
        var progress: Double = 0.0
        
        var currentBook: Book? = AtomicHabits
        var keyPointDuration: Int = 0
        var currentKeyPoint: Int = 0
        var currentSpeedPlayback: PlaybackSpeed = .normal
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onTapPlay, onTapStop, onTapPause, onTapForward(TimeInterval), onTapBackward(TimeInterval)
        case updateProgress
        case onSliderChange(Double)
        case task
        
//        case fetchBook(Book)
        case switchKeyPoint(KeyPointSwitchDirection)
        case switchSpeedPlayback
    }
    
    @Dependency(\.continuousClock) var clock
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .binding: return .none
            case .task:
                return .none
            case .updateProgress:
                return self.updateProgress(state: &state)
            case .onTapPlay:
                state.avAudioPlayer?.enableRate = true
                state.avAudioPlayer?.play()
                return .concatenate(
                    .run { @MainActor send in
                        while true {
                            try await self.clock.sleep(for: .seconds(1))
                            send(.updateProgress)
                        }
                    }.cancellable(id: "onTapPlay", cancelInFlight: true),
                    
                    self.update(state: &state, isPlaying: true)
                )
                
            case .onTapStop:
                state.avAudioPlayer?.stop()
                return .concatenate(
                    .cancel(id: "onTapStop"),
                    self.update(state: &state, isPlaying: false)
                )
            case .onTapBackward(let time):
                state.avAudioPlayer?.currentTime -= time
                return self.updateProgress(state: &state)
                
            case .onTapForward(let time):
                state.avAudioPlayer?.currentTime += time
                return self.updateProgress(state: &state)
            case .onTapPause:
                state.avAudioPlayer?.pause()
                return .concatenate(
                    .cancel(id: "onTapPlay"),
                    self.update(state: &state, isPlaying: false)
                )
            case .onSliderChange(let time):
                state.avAudioPlayer?.currentTime = time * (state.avAudioPlayer?.duration ?? 0)
                return self.updateProgress(state: &state)
                
//            case .fetchBook(let book):
//                state.currentBook = book
//                return .none
            case .switchKeyPoint(let direction):
                state.currentKeyPoint = keyPointSwitch(book: state.currentBook, currentKeyPoint: state.currentKeyPoint, direction: direction)
                return .none
            case .switchSpeedPlayback:
                state.currentSpeedPlayback = playbackSpeedSwitch(state.currentSpeedPlayback)
                state.avAudioPlayer?.rate = state.currentSpeedPlayback.rawValue
                return self.update(state: &state, isPlaying: state.isPlaying)
            }
        }
    }
    
    func update(state: inout State, isPlaying: Bool) -> Effect<Action> {
        return .concatenate(
            self.updateProgress(state: &state),
            self.updateIsPlaying(to: isPlaying, inState: &state)
        )
    }
    
    func updateProgress(state: inout State) -> Effect<Action> {
        state.progress = state.avAudioPlayer?.progress ?? 0.0
        return .none
    }
    
    func updateIsPlaying(to newValue: Bool, inState state: inout State) -> Effect<Action> {
        state.isPlaying = newValue
        return .none
    }
}

struct SharedAudioPlayerView: View {
    @State private var isUserInteracting: Bool = false
    @State private var isShownTextSummary: Bool = false
    
    @Bindable var store: StoreOf<SharedAudioPlayerReducer> = .init(
        initialState: SharedAudioPlayerReducer.State(
            avAudioPlayer: Shared.init(
                wrappedValue: try? AVAudioPlayer(
                    contentsOf: Bundle.main.url(forResource: "Atomic_Habits_audio_summary", withExtension: "mp3")!
                ),
                .inMemory("audio")
            )
        )
    ) {
        SharedAudioPlayerReducer()._printChanges()
    }
    var body: some View {
        if let audioPlayer = store.avAudioPlayer {
            self.myPlayer
        } else {
            ContentUnavailableView("No audio player", image: "trash")
        }
    }
    
    @ViewBuilder var myPlayer: some View {
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
                        Text(.seconds(store.avAudioPlayer?.currentTime ?? 0.0), format: .time(pattern: .minuteSecond))
                        Slider(
                            value: Binding(
                                get: { store.progress },
                                set: { newValue in
                                    if self.isUserInteracting {
                                        print("User manually moved the slider to \(newValue)")
                                        
                                        store.send(.onSliderChange(newValue))
                                    } else {
                                        print("Slider value changed programmatically to \(newValue)")
                                    }
                                }),
                            in: 0...1,
                            onEditingChanged: { editing in
                                self.isUserInteracting = editing
                                if !editing {
                                    print("User finished sliding")
                                }
                            }
                        )
                        Text("-")+Text(.seconds(store.avAudioPlayer?.duration ?? 0.0), format: .time(pattern: .minuteSecond))
                    }
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding()
                
                    Button(action: {
//                        currentSpeed = playbackSpeedSwitch(currentSpeed)
                        store.send(.switchSpeedPlayback)
                    }) {
                        Text("x\(formatFloatToStringSpeed(store.currentSpeedPlayback.rawValue)) speed")
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
                            store.send(.onTapBackward(5))
                        }) {
                            Image(systemName: "gobackward.5")
                        }
                        .font(.title)
                        
                        Button(action: {
                            if store.isPlaying == .some(true) {
                                store.send(.onTapPause)
                            } else {
                                store.send(.onTapPlay)
                            }
                        }) {
                            Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        Button(action: {
                            store.send(.onTapForward(10))
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
//            store.send(.fetchBook(AtomicHabits))
        }
    }
    
    @ViewBuilder var playerView: some View {
        VStack {
            Grid {
                Slider(
                    value: Binding(
                        get: { store.progress },
                        set: { newValue in
                            if self.isUserInteracting {
                                print("User manually moved the slider to \(newValue)")
                                
                                store.send(.onSliderChange(newValue))
                            } else {
                                print("Slider value changed programmatically to \(newValue)")
                            }
                        }),
                    in: 0...1,
                    onEditingChanged: { editing in
                        self.isUserInteracting = editing
                        if !editing {
                            print("User finished sliding")
                        }
                    }
                )
                
                GridRow {
                    Text(.seconds(store.avAudioPlayer?.currentTime ?? 0.0), format: .time(pattern: .minuteSecond))
                    Spacer()
                    Text("-") + Text(.seconds(store.avAudioPlayer?.duration ?? 0.0), format: .time(pattern: .minuteSecond))
                }.padding(0)
                    .font(.caption).foregroundStyle(.gray)
                    .monospacedDigit()
            }
            
            HStack {
                Group {
                    Button("Backward 30 s", systemImage: "gobackward.30") {
                        store.send(.onTapBackward(30))
                    }
                    
                    self.playPauseBtn
                    Button("Forward 30 s", systemImage: "goforward.30") {
                        store.send(.onTapForward(30))
                    }
                }.frame(maxWidth: .infinity)
                    .font(.title)
            }
            .labelStyle(.iconOnly)
            
        }.padding()
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder var playPauseBtn: some View {
        
        Button("Play/Pause", systemImage: store.isPlaying == .some(true) ? "pause.circle.fill" : "play.circle.fill") {
            if store.isPlaying == .some(true) {
                store.send(.onTapPause)
            } else {
                store.send(.onTapPlay)
            }
        }.font(.largeTitle)
    }
}


#Preview {
    SharedAudioPlayerView()
}
