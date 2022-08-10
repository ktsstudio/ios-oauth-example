//
//  GithubRouter.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 26.07.2022.
//

import Moya

protocol GithubRouterProtocol: TargetType {
    
    var tokenStorage: TokenStorage { get }
    
    var baseURL: URL { get }
    var headers: [String : String]? { get }
    var sampleData: Data { get }
}

extension GithubRouterProtocol {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    var headers: [String : String]? {
        guard let token = tokenStorage.getToken()?.access else {
            return nil
        }
        return ["Authorization": "token \(token)"]
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
