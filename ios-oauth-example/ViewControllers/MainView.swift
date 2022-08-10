//
//  MainView.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 26.07.2022.
//

import Foundation
import UIKit

final class MainView: UIView {
    private let spaceConstant: CGFloat = 16
    private let heightConstant: CGFloat = 48
    
    lazy var loginButton: UIButton = {
        return getButton(title: "Login", color: .green)
    }()
    
    lazy var logoutButton: UIButton = {
        return getButton(title: "Logout", color: .red)
    }()
    
    lazy var openDataButton: UIButton = {
        return getButton(title: "Open data", color: .blue)
    }()
    
    lazy var openUrlButton: UIButton = {
        return getButton(title: "Open URL", color: .blue)
    }()
    
    private lazy var stackView: UIStackView = {
        let outputStackView = UIStackView()
        
        outputStackView.axis = .horizontal
        outputStackView.translatesAutoresizingMaskIntoConstraints = false
        outputStackView.spacing = 16.0
        outputStackView.distribution = .fillEqually
        return outputStackView
    }()
    
    func setupLayout() {
        backgroundColor = .white
        [openDataButton,
         stackView,
         openUrlButton].forEach {
            addSubview($0)
        }
        
        [loginButton,
         logoutButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: spaceConstant),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -spaceConstant),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                              constant: -spaceConstant),
            stackView.heightAnchor.constraint(equalToConstant: heightConstant),
            
            openDataButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            openDataButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: spaceConstant),
            openDataButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -spaceConstant),
            openDataButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            openDataButton.heightAnchor.constraint(equalToConstant: heightConstant),
            
            openUrlButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            openUrlButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: spaceConstant),
            openUrlButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -spaceConstant),
            openUrlButton.topAnchor.constraint(equalTo: openDataButton.bottomAnchor,
                                               constant: spaceConstant),
            openUrlButton.heightAnchor.constraint(equalToConstant: heightConstant),
        ])
    }
    
    private func getButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        return button
    }
}
