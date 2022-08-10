//
//  UserDefaultsHelper.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import Foundation

protocol TokenStorage {
    func getToken() -> TokenModel?
}

final class UserDefaultsHelper: TokenStorage {
    enum UserDefaultsKeys: String {
        case token
    }
    
    func setToken(value: TokenModel) {
        let encodedToken = try? PropertyListEncoder().encode(value)
        let defaults = UserDefaults.standard
        defaults.set(encodedToken, forKey: UserDefaultsKeys.token.rawValue)
    }
    
    func getToken() -> TokenModel? {
        let defaults = UserDefaults.standard
        guard let propertyToken = defaults.object(forKey: UserDefaultsKeys.token.rawValue) as? Data
        else {
            return nil
        }
        return try? PropertyListDecoder().decode(TokenModel.self, from: propertyToken)
    }
    
    func clearToken() {
       let defaults = UserDefaults.standard
       defaults.removeObject(forKey: UserDefaultsKeys.token.rawValue)
    }
}
