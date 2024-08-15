//
//  BookDetailEnvironment.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 13.08.2024.
//

import Combine
import Foundation

struct BookDetailsEnvironment {
    var audioPlayer: AudioPlayer
}

struct AudioPlayer {
    private var currentTimeSubject = CurrentValueSubject<TimeInterval, Never>(0)
    
    func play() { /* Play implementation */ }
    func pause() { /* Pause implementation */ }
    func seek(to time: TimeInterval) { /* Seek implementation */ }
    func changeSpeed(to speed: Float) { /* Change speed implementation */ }
    var currentTimePublisher: AnyPublisher<TimeInterval, Never> {
        // Publisher for current playback time
        return currentTimeSubject.eraseToAnyPublisher()
    }
}
