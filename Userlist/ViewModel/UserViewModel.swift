//
//  UserViewModel.swift
//  Userlist
//
//  Created by Raj Kumar on 06/04/24.
//

import Foundation

enum APIError: Error {
    case invalidUrl, requestError, decodingError, statusNotOk
}

class UserViewModel: ObservableObject {
    
    @Published var userList = [UserlistModel]()
    
    func getUserListData(completion: @escaping () -> Void) {
        guard let url = URL(string: ApiConfig.userList) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(AccessToken.primaryToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Userlist.self, from: data)
                DispatchQueue.main.async {
                    self.userList = decodedData
                    completion()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func createNewUser(param: [String: Any], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: ApiConfig.userList) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(AccessToken.primaryToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let postData = try? JSONSerialization.data(withJSONObject: param) else {
            print("Error converting parameters to data")
            return
        }
        
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(false, error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response: \(response.debugDescription)")
                completion(false, response.debugDescription)
                return
            }
            if let data = data,
               let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(true, responseString)
                }
            }
        }.resume()
    }
    
}
