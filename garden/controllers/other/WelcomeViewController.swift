//
//  WelcomeViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    private lazy var loginButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Login", for: .normal)
        //btn.backgroundColor = .black
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func addSubviews() {
        view.addSubview(loginButton)
    }
    func configureConstraints() {
        configureLoginButton()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Название"
        
        self.view.backgroundColor = .systemBackground
        addSubviews()
        configureConstraints()
    }
    func configureLoginButton()   {
        loginButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }


}
