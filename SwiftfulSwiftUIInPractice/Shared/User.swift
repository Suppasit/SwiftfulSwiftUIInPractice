//
//  User.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 18/7/2567 BE.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    var work: String {
       "Worker as Some Job" 
    }
    var educaton: String {
        "Graduate Degree"
    }
    var aboutMe: String {
        "This is a sentence about me that will look good on my profile!"
    }
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: educaton),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.star.fill", emoji: nil, text: "Virgo")
        ]
    }
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "👟", text: "Running"),
            UserInterest(iconName: nil, emoji: "🏋️‍♂️", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🎧", text: "Music"),
            UserInterest(iconName: nil, emoji: "🥘", text: "Cooking")
        ]
    }
    var images: [String] {
        ["https://picsum.photos/500/500", "https://picsum.photos/600/600", "https://picsum.photos/600/700", "https://picsum.photos/500/700"]
    }

    static var mock: User {
        User(
            id: 444,
            firstName: "Nick",
            lastName: "Sarano",
            age: 76,
            email: "hi@hi.com",
            phone: "",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
