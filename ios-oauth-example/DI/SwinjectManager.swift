//
//  SwinjectManager.swift
//  ios-oauth-example
//
//  Created by Елена Качармина on 20.11.2022.
//

import Swinject

final class SwinjectManager {
    
    static let shared = SwinjectManager()
    
    private init() {}
    
    private let assembler = Assembler([MainAssembly(),
                                       DataAssembly()])
    
    var firstVC: UIViewController? {
        guard let rootVC = assembler.resolver.resolve(MainViewController.self) else {
            return nil
        }
        
        return UINavigationController(rootViewController: rootVC)
    }
    
    var dataVC: UIViewController? {
        return assembler.resolver.resolve(DataViewController.self)
    }
}
