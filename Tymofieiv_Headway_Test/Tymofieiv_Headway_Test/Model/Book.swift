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
    let bookCoverImage: URL
    let keyPoints: [KeyPoint]
}

struct KeyPoint {
    let id: Int
    let name: String
    let duration: Float
    let audioURL: URL
}

let AtomicHabits = Book(
    title: "Atomic Habits",
    author: "James Clear",
    summaryText: "Learn about the easy and proven way to build good habits and break the bad ones. What’s a habit? If someone were to ask you about your daily habits, you might need some time to think about them. That’s because a habit, by definition, is an act that you perform automatically by instinct. Like when you walk into a dark room, you instinctively turn on a light switch, right? Habits are actions you don’t even have to think about, which is why you might not realize how a small daily action can have a powerful effect on your life. If you’re saving a dollar a day or smoking a cigarette a day, these actions may not seem like much now, but twenty years from now, those habits can either make you rich or, unfortunately, kill you. That’s why it’s important to understand how habits are formed, so you can learn how to kick the bad habits, implement the healthy ones, and take back control of your life.",
    bookCoverImage: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_cover", ofType: "jpeg") ?? "ERROR"),
    keyPoints: [
        KeyPoint(
            id: 0,
            name: "Introduction",
            duration: 65.5,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_1", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 1,
            name: "Why Small Habits Can Make A Big Difference",
            duration: 140.2,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_2", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 2,
            name: "How Habits Are Formed",
            duration: 159,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_3", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 3,
            name: "Make It Obvious",
            duration: 156.3,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_4", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 4,
            name: "Make It Attractive",
            duration: 158,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_5", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 5,
            name: "Make It Easy",
            duration: 177,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_6", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 6,
            name: "Make It Satisfying",
            duration: 168,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_7", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 7,
            name: "The Importance of Habit Tracking",
            duration: 188.43,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_8", ofType: "mp3") ?? "ERROR")
        ),
        KeyPoint(
            id: 8,
            name: "Final Summary",
            duration: 50.6,
            audioURL: URL(fileURLWithPath: Bundle.main.path(forResource: "Atomic_Habits_key_9", ofType: "mp3") ?? "ERROR")
        )
    ])
