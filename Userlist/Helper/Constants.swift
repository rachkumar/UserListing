//
//  Constants.swift
//  Userlist
//
//  Created by Raj Kumar on 06/04/24.
//

import Foundation

struct ApiConfig {
    static let baseURL = "https://gorest.co.in/public/v2/"
    static let userList = baseURL + "users"
}

struct AccessToken {
    static let primaryToken = "93f32cfce099897a06b14076e138bd3ba96227461da6cc3f127cfa4e2f50365d"
}

struct AlertMessage {
    static let enterName = "Enter your name"
    static let enterEmail = "Enter your Email ID"
    static let selectGender = "Select your gender"
    static let nameValidationMsg = "Your name should not be less than 3 character or more than 15 character"
    static let enterValidEmail = "Enter valid Email ID"
    static let userAddedMessage = "User Added Successfully"
}
