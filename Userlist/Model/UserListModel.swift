//
//  UserListModel.swift
//  Userlist
//
//  Created by Raj Kumar on 06/04/24.
//

import Foundation

// MARK: - UserlistModel
struct UserlistModel: Codable {
    let id: Int
    let name, email: String
    let gender: Gender
    let status: Status
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}

typealias Userlist = [UserlistModel]
