//
//  PlaybackSpeed.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 13.08.2024.
//

import Foundation

enum PlaybackSpeed: String, CaseIterable {
    case normal = "1x"
    case x1_25 = "1.25x"
    case x1_5 = "1.5x"
    case x1_75 = "1.75x"
    case x2 = "2x"
    case x0_5 = "0.5x"
}

enum KeyPointSwitchDirection {
    case forward
    case backward
}
