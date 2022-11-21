//
//  DataRepository.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import Foundation
import RxSwift
import Moya

final class DataRepository {
    
    private let userDefaultsHelper: UserDefaultsHelper
    private let provider: MoyaProvider<DataRouter>
    
    init(userDefaultsHelper: UserDefaultsHelper?,
         provider: MoyaProvider<DataRouter>?) {
        guard let userDefaultsHelper = userDefaultsHelper,
              let provider = provider
        else { fatalError("DataRepository init") }
        
        self.userDefaultsHelper = userDefaultsHelper
        self.provider = provider
    }
    
    func getUserData() -> Single<String> {
        return provider.rx
            .request(DataRouter.userData)
            .mapString()
            .catchError({ error in
                throw CustomError.badRequest
            })
    }
}
