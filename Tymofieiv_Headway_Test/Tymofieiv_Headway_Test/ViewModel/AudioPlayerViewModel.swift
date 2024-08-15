//
//  AudioPlayerViewModel.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 12.08.2024.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying = false
    @Published var currentTime: Float = 0
    
    init() {
        if let sound = Bundle.main.path(forResource: "Atomic_Habits_audio_summary", ofType: "mp3") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            } catch {
                print("AVAudioPlayer could not be instantiated.")
            }
        } else {
            print("Audio file could not be found.")
        }
    }
    
    func playOrPause(at time: Float) {
        guard let player = audioPlayer else { return }
        currentTime = Float(player.currentTime)
        player.currentTime = Double(time)
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
  }
}

