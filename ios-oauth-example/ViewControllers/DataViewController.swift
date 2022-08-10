//
//  DataViewController.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import UIKit
import RxSwift

final class DataViewController: UIViewController {
    private let repository = DataRepository()
    private let disposeBag = DisposeBag()
    
    private lazy var dataLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.numberOfLines = 0
        
        return outputLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dataLabel)
        
        NSLayoutConstraint.activate([
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dataLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dataLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        repository.getUserData().subscribe { [weak self] data in
            self?.dataLabel.text = data
        } onError: { [weak self] _ in
            self?.dataLabel.text = "Error"
        }.disposed(by: disposeBag)
    }
}
