//
//  Reducer.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 13.08.2024.
//

//import Combine
import ComposableArchitecture
import Foundation

//func appReducer(action: Int, state: BookDetailsState?) -> BookDetailsState {
//    var state = state ?? BookDetailsState()
//    switch action as? AppAction {
//    case .fetchBook:
//        state.currentBook = AtomicHabits
//    case .playAudio:
//        state.isPlaying.toggle()
//    case .switchKeyPoint:
//        state.currentKeyPoint = keyPointSwitch(book: state.currentBook, currentKeyPoint: state.currentKeyPoint)
//    case .switchSpeedPlayback:
//        state.currentSpeedPlayback = playbackSpeedSwitch(state.currentSpeedPlayback)
//    case .none:
//        break
//    }
    
//    return state
//}

//let bookDetailsReducer = Reducer<BookDetailsState, BookDetailsAction> { state, action, environment in
//    switch action {
//    case .playPause:
//        state.isPlaying.toggle()
//        if state.isPlaying {
//            environment.audioPlayer.play()
//        } else {
//            environment.audioPlayer.pause()
//        }
////        return .none
//        
//    case let .changeSpeed(speed):
//        state.playbackSpeed = speed
//        environment.audioPlayer.changeSpeed(to: speed)
//        return .none
//        
//    case .seekForward:
//        let newTime = min(state.currentTime + 10, state.duration)
//        environment.audioPlayer.seek(to: newTime)
//        state.currentTime = newTime
//        return .none
//        
//    case .seekBackward:
//        let newTime = max(state.currentTime - 5, 0)
//        environment.audioPlayer.seek(to: newTime)
//        state.currentTime = newTime
//        return .none
//        
//    case let .updateCurrentTime(time):
//        state.currentTime = time
//        return .none
//    }
//}

