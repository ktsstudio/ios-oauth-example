//
//  OAuthRepository.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import AppAuth

class OAuthRepository {
    
    private let userDefaultsHelper: UserDefaultsHelper
    private let appDelegate: AppDelegate
    
    weak var viewController: UIViewController?
    
    private let configuration = OIDServiceConfiguration.init(
        authorizationEndpoint: URL(string: AuthConfiguration.baseUrl + AuthConfiguration.authUri)!,
        tokenEndpoint: URL(string: AuthConfiguration.baseUrl + AuthConfiguration.tokenUri)!,
        issuer: nil,
        registrationEndpoint: nil,
        endSessionEndpoint: URL(string: AuthConfiguration.baseUrl + AuthConfiguration.endSessionUri)!)
    
    init(userDefaultsHelper: UserDefaultsHelper?,
         appDelegate: AppDelegate?) {
        guard let userDefaultsHelper = userDefaultsHelper,
              let appDelegate = appDelegate
        else { fatalError("OAuthRepository init") }
        
        self.userDefaultsHelper = userDefaultsHelper
        self.appDelegate = appDelegate
    }
    
    func login() {
        guard let viewController = viewController else {
            return
        }
        
        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: AuthConfiguration.clientId,
            clientSecret: AuthConfiguration.clientSecret,
            scopes: AuthConfiguration.scopes,
            redirectURL: URL(string: AuthConfiguration.callbackUrl)!,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil)
        
        let agent = OIDExternalUserAgentIOSSafariViewController(presentingViewController: viewController)
        
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, externalUserAgent: agent) { [weak self] authState, error in
            if error == nil {
                let tokenModel = TokenModel(access: authState?.lastTokenResponse?.accessToken,
                                            refresh: authState?.lastTokenResponse?.refreshToken)
                self?.userDefaultsHelper.setToken(value: tokenModel)
            }
        }
    }
    
    func logout() {
        guard let accessToken = userDefaultsHelper.getToken()?.access,
        let viewController = viewController else { return }
        let request =  OIDEndSessionRequest(configuration: configuration,
                                            idTokenHint: accessToken,
                                            postLogoutRedirectURL: URL(string: AuthConfiguration.logoutCallbackUrl)!,
                                            additionalParameters: nil)
        
        let agent = OIDExternalUserAgentIOSSafariViewController(presentingViewController: viewController)
        
        appDelegate.currentAuthorizationFlow = OIDAuthorizationService.present(request, externalUserAgent: agent) { [weak self] (response, error) in
            self?.userDefaultsHelper.clearToken()
        }
    }
    
    func refreshToken() {
        guard let refreshToken = userDefaultsHelper.getToken()?.refresh else { return }
        let requestRefresh = OIDTokenRequest(
            configuration: configuration,
            grantType: OIDGrantTypeRefreshToken,
            authorizationCode: nil,
            redirectURL: nil,
            clientID: AuthConfiguration.clientId,
            clientSecret: AuthConfiguration.clientSecret,
            scope: nil,
            refreshToken: refreshToken,
            codeVerifier: nil,
            additionalParameters: nil)
        
        OIDAuthorizationService.perform(requestRefresh) { [weak self] tokenResponse, error in
            
            if error == nil {
                let tokenModel = TokenModel(access: tokenResponse?.accessToken,
                                            refresh: tokenResponse?.refreshToken)
                self?.userDefaultsHelper.setToken(value: tokenModel)
            }
        }
    }
}
