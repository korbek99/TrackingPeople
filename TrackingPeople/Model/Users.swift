//
//  Users.swift
//  TrackingPeople
//
//  Created by Jose David Bustos H on 28-09-19.
//

import Foundation

struct Users: Codable {
    let id: Int
    let name: String
    let lastname: String
    let username: String
    let password: String
}

let usersList: [Users] = [
    Users(id: 1, name: "Juan", lastname: "Pérez", username: "juan.perez", password: "123")
]
