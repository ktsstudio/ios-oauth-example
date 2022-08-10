//
//  DataRouter.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 26.07.2022.
//

import Moya

enum DataRouter: GithubRouterProtocol {
    var tokenStorage: TokenStorage {
        UserDefaultsHelper()
    }
    case userData
    
    var path: String {
        switch self {
        case .userData:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userData:
            return .requestPlain
        }
    }
}
