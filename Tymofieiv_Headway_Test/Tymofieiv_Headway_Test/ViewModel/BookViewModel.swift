//
//  BookViewModel.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import AVFoundation
import Foundation

class BookViewModel: ObservableObject {
    @Published var books: [Book] = [] // Load your books here
    @Published var currentBook: Book?
    @Published var isPlaying: Bool = false

    private var audioPlayer: AVAudioPlayer?

    func playAudio(for book: Book) {
        let url = book.audioFileURL
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Failed to play audio: \(error)")
        }
    }

    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }

    func seekBackward() {
        audioPlayer?.currentTime -= 5
    }

    func seekForward() {
        audioPlayer?.currentTime += 10
    }
}
