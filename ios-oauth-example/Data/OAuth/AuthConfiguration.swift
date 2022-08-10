//
//  AuthConfiguration.swift
//  ios-oauth-example
//

struct AuthConfiguration {
    static let baseUrl = "https://github.com/"
    static let authUri = "login/oauth/authorize"
    static let tokenUri = "login/oauth/access_token"
    static let endSessionUri = "logout"
    static let scopes = ["user", "repo"]
    static let clientId = "..."
    static let clientSecret = "..."
    static let callbackUrl = "ru.kts.oauth://github.com/callback"
    static let logoutCallbackUrl = "ru.kts.oauth://github.com/logout_callback"
}
