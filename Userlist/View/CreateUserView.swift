//
//  CreateUserView.swift
//  Userlist
//
//  Created by Raj Kumar on 06/04/24.
//

import SwiftUI

struct CreateUserView: View {
    
    @StateObject var viewModel = UserViewModel()
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userGender: String = ""
    
    @State private var isMale: Bool = false
    @State private var isFemale: Bool = false
    
    @State private var showAlert = false
    @State private var alertMsg: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter Name", text: $userName).keyboardType(.alphabet)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter Email ID", text: $userEmail).keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                Text("Select Gender")
                Picker(selection: $userGender, label: Text("Gender")) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                .pickerStyle(SegmentedPickerStyle())
                Button(action: {
                    validateUserData { success, message in
                        if success {
                            let parameters = [
                                "name": userName,
                                "gender": userGender.lowercased(),
                                "email": userEmail,
                                "status": "active"
                            ]
                            viewModel.createNewUser(param: parameters) { success, messageData in
                                showAlert = true
                                alertMsg = success ? AlertMessage.userAddedMessage : messageData
                            }
                        } else {
                            alertMsg = message
                            showAlert = true
                        }
                    }
                }) {
                    Text("Add User")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                Spacer()
            }.padding(40.0)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Alert"),
                        message: Text(alertMsg),
                        dismissButton: .default(Text("OK"), action: {
                            if alertMsg == AlertMessage.userAddedMessage {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        })
                    )
                }
        }
        .navigationTitle("Add User")
    }
    
    func validateUserData(closure: (Bool, String) -> Void) -> () {
        if userName.isEmpty {
            closure(false, AlertMessage.enterName)
            return
        }
        if userEmail.isEmpty {
            closure(false, AlertMessage.enterEmail)
            return
        }
        if userGender.isEmpty {
            closure(false, AlertMessage.selectGender)
            return
        }
        if userName.count < 3 || userName.count > 15 {
            closure(false, AlertMessage.nameValidationMsg)
            return
        }
        if !userEmail.isValidEmail() {
            closure(false, AlertMessage.enterValidEmail)
            return
        }
        closure(true, "success")
    }
    
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
