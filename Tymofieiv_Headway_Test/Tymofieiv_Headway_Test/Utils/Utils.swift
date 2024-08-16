//
//  Utils.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 12.08.2024.
//

import Foundation

func playbackSpeedSwitch(_ currentSpeed: PlaybackSpeed) -> PlaybackSpeed {
    let allCases = PlaybackSpeed.allCases
    if currentSpeed != allCases.last, let indexCurrent = allCases.firstIndex(of: currentSpeed) {
        return allCases[indexCurrent + 1]
    } else {
        return allCases[0]
    }
}

func keyPointSwitch(keyPoints: [KeyPoint], currentKeyPoint: Int, direction: KeyPointSwitchDirection) -> Int {
    var newKeyPoint = currentKeyPoint
    switch direction {
    case .forward:
        if let lastKeyPoint = keyPoints.last?.id, currentKeyPoint < lastKeyPoint {
            newKeyPoint += 1
        } else {
            newKeyPoint = 0
        }
    case .backward:
        if currentKeyPoint > 0 {
            newKeyPoint -= 1
        } else {
            newKeyPoint = 0
        }
    }
    
    return newKeyPoint
}

func formatFloatToStringSpeed(_ value: Float) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}
