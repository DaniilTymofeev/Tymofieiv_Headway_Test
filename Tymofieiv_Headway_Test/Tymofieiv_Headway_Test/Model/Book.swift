//
//  BookModel.swift
//  Tymofieiv_Headway_Test
//
//  Created by Danil Tymofeev on 11.08.2024.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let summaryText: String
    let audioFileURL: URL
    let bookCoverImage: URL
    let chapters: [Chapter]
}

struct Chapter {
    let id: Int
    let name: String
    let startTime: Int
}

let AtomicHabits = Book(
    title: "Atomic Habits",
    author: "James Clear",
    summaryText: "Learn about the easy and proven way to build good habits and break the bad ones. What’s a habit? If someone were to ask you about your daily habits, you might need some time to think about them. That’s because a habit, by definition, is an act that you perform automatically by instinct. Like when you walk into a dark room, you instinctively turn on a light switch, right? Habits are actions you don’t even have to think about, which is why you might not realize how a small daily action can have a powerful effect on your life. If you’re saving a dollar a day or smoking a cigarette a day, these actions may not seem like much now, but twenty years from now, those habits can either make you rich or, unfortunately, kill you. That’s why it’s important to understand how habits are formed, so you can learn how to kick the bad habits, implement the healthy ones, and take back control of your life.",
    audioFileURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_audio_summary", ofType: "mp3") ?? "ERROR"),
    bookCoverImage: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_cover", ofType: "jpeg") ?? "ERROR"),
    chapters: [
        Chapter(id: 0, name: "Introduction", startTime: 0),
        Chapter(id: 1, name: "Why Small Habits Can Make A Big Difference", startTime: 66),
        Chapter(id: 2, name: "How Habits Are Formed", startTime: 207),
        Chapter(id: 3, name: "Make It Obvious", startTime: 368),
        Chapter(id: 4, name: "Make It Attractive", startTime: 525),
        Chapter(id: 5, name: "Make It Easy", startTime: 685),
        Chapter(id: 7, name: "Make It Satisfying", startTime: 865),
        Chapter(id: 8, name: "The Importance of Habit Tracking", startTime: 1034),
        Chapter(id: 9, name: "Final Summary", startTime: 1224)
    ])
