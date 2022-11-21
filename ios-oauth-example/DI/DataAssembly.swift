//
//  DataAssembly.swift
//  ios-oauth-example
//
//  Created by Елена Качармина on 21.11.2022.
//

import Swinject
import Moya

final class DataAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(DataRepository.self) { resolver in
            let userDefaultsHelper = resolver.resolve(UserDefaultsHelper.self)
            let provider = resolver.resolve(MoyaProvider<DataRouter>.self)
            return DataRepository(userDefaultsHelper: userDefaultsHelper,
                                   provider: provider)
        }
        
        container.register(MoyaProvider<DataRouter>.self) { _ in
            return MoyaProvider<DataRouter>()
        }
        
        container.register(DataViewController.self) { resolver in
            let repository = resolver.resolve(DataRepository.self)
            return DataViewController(repository: repository)
        }
    }
}
