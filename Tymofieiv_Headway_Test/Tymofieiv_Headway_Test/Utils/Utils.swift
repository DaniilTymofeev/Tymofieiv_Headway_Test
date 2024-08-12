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

