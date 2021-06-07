//
//  APICaller.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    private init(){}

    struct Constants {
        static let baseAPIURL = "http://167.172.230.26:8000"
    }
    // Enum: API Errors
    enum APIError: Error {
        case failedToGetData
    }
public func getAllHacks(completion: @escaping ((Result<[Hack],Error>)->Void)){
        createRequest(with: URL(string: Constants.baseAPIURL + "/hacks/all"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }

               
                do{
                    print("fsdfksdfsdfsdfsdfijsdfi")
                    print(data)
                    let result = try JSONDecoder().decode([Hack].self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("going here ..... ")
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

//
//    //MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile,Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/users/profile"),
                      type: .GET
        ) { baseRequest in
            
            var request = baseRequest
            
            let accessToken = AuthManager.shared.accessToken!
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json",
                                            forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    print("here")
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    //MARK: - Private
    //Enum: for HTTP Method
    enum HTTPMethod: String {
        case GET
        case POST
    }
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void){
        //AuthManager.shared.withValidToken { token in
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            //request.setValue("Bearer \(token)",
            //                 forHTTPHeaderField: "Authorization")
            //set HTTP Method from the enum
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            // Call the completion handler with request
            completion(request)
        //}
    }
}
