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

  init() {
    if let sound = Bundle.main.path(forResource: "Atomic_Habits_by_James_Clear", ofType: "mp3") {
      do {
        self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
      } catch {
        print("AVAudioPlayer could not be instantiated.")
      }
    } else {
      print("Audio file could not be found.")
    }
  }

  func playOrPause() {
    guard let player = audioPlayer else { return }

    if player.isPlaying {
      player.pause()
      isPlaying = false
    } else {
        player.currentTime = 66
      player.play()
      isPlaying = true
    }
  }
}

