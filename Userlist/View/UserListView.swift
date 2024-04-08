//
//  UserListView.swift
//  Userlist
//
//  Created by Raj Kumar on 06/04/24.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserViewModel()
    @State private var isShowCreateUser = false
    
    var body: some View {
        NavigationView {
            List(viewModel.userList, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                    Text("Gender: \(user.gender.rawValue.capitalized)")
                        .font(.subheadline)
                    Text("Status: \(user.status.rawValue.capitalized)")
                        .font(.subheadline)
                }
                .listStyle(.grouped)
            }
            .navigationTitle("Userlist")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: CreateUserView(), isActive: $isShowCreateUser) {
                Image(systemName: "plus")
            }
            )
            .onAppear {
                viewModel.getUserListData {}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
