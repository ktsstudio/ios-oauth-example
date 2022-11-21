//
//  MainViewController.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let repository: OAuthRepository
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    
    init(repository: OAuthRepository?) {
        guard let repository = repository
        else { fatalError("MainViewController init") }
        
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainViewController has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupLayout()
        bindUI()
    }
    
    private func bindUI() {
        mainView.loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.login()
        }).disposed(by: disposeBag)
        
        mainView.logoutButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.logout()
        }).disposed(by: disposeBag)
        
        mainView.openDataButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.openData()
        }).disposed(by: disposeBag)
        
        mainView.openUrlButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.openUrl()
        }).disposed(by: disposeBag)
    }
    
    private func login() {
        repository.login()
    }
    
    private func logout() {
        repository.logout()
    }
    
    private func openData() {
        guard let vc = SwinjectManager.shared.dataVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openUrl() {
        let config = SFSafariViewController.Configuration()
        let vc = SFSafariViewController(url: URL(string: "https://github.com")!, configuration: config)
        self.present(vc, animated: true)
    }
}
