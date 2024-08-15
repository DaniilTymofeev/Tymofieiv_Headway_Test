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

func keyPointSwitch(book: Book?, currentKeyPoint: Int, direction: KeyPointSwitchDirection) -> Int {
    guard let book = book else { return currentKeyPoint }
    var newKeyPoint = currentKeyPoint
    switch direction {
    case .forward:
        if let lastKeyPoint = book.chapters.last?.id, currentKeyPoint < lastKeyPoint {
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

func calculateKeyPointTimeIntervals(book: Book, keyPointIndex: Int, fullDuration: Int) -> (Int, Int) {
    var startAndEndTimeIntervals = (0, 0)
    let currentKeyPoint = book.chapters[keyPointIndex]
    if let lastChapter = book.chapters.last, currentKeyPoint.id != lastChapter.id {
        startAndEndTimeIntervals = (currentKeyPoint.startTime, book.chapters[keyPointIndex + 1].startTime)
    } else {
        startAndEndTimeIntervals = (currentKeyPoint.startTime, fullDuration)
    }
    
    return startAndEndTimeIntervals
}

