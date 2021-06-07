//
//  AuthManager.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import Foundation


final class AuthManager{
    static let shared = AuthManager()
    struct Constants {
        static let baseAPIURL = "http://167.172.230.26:8000"
    }
    private init() {}
    var isSignedIn: Bool{
        return true
    }
    public var accessToken: String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private func cacheToken(result:AuthResponse){
        UserDefaults.standard.setValue(result.access_token,
                                       forKey: "access_token")

        
    }
    public func logIn(
        login:String,
        password:String,
        completion: @escaping ((Bool) -> (Void))
    ){
        //Get Token
        print(login)
        print(password)
        guard let url = URL(string: Constants.baseAPIURL+"/users/token") else {
            return
        }

        
        let data : Data = "username=\(login)&password=\(password)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data

        print("one called")

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        // vs let session = URLSession.shared
          // make the request
        let task = session.dataTask(with: request) { [weak self](data, _, error) in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            do{
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)

                self?.cacheToken(result:result)
                completion(true)
                
            }
            catch{

                completion(false)
            }
        }
        task.resume()
        
    }
    public func signUp(
        login:String,
        password:String,
        completion: @escaping ((Bool) -> (Void))
    ){
        //Get Token
 
        guard let url = URL(string: Constants.baseAPIURL+"/users/create") else {
            return
        }

        
        let data : Data = "username=\(login)&password=\(password)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data


        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        // vs let session = URLSession.shared
          // make the request
        let task = session.dataTask(with: request) { [weak self](data, _, error) in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            do{
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print(result)
                self?.cacheToken(result:result)
                completion(true)
                
            }
            catch{


                completion(false)
            }
        }
        task.resume()
        
    }
    
}
