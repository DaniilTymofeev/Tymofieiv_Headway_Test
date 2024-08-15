//
//  PlaybackSpeed.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 13.08.2024.
//

import Foundation

enum PlaybackSpeed: Float, CaseIterable {
    case normal = 1
    case x1_25 = 1.25
    case x1_5 = 1.5
    case x1_75 = 1.75
    case x2 = 2
    case x0_5 = 0.5
}

enum KeyPointSwitchDirection {
    case forward
    case backward
}
