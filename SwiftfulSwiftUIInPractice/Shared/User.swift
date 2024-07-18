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
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
}
