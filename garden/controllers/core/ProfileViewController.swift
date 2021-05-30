//
//  LibraryViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    let lightGreen = UIColor(rgb: 0x43dfa8)
    let black = UIColor.black
    public var completionHandler: ((Bool)->Void)?

    private lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.text = "Ошибка"
        label.alpha = 0
        return label
    }()
    private lazy var loginField: UITextField = {
        var field = UITextField()
        field.styleField()
        field.placeholder = "Почта"
       return field
    }()
    private lazy var passwordField: UITextField = {
        var field = UITextField()
        field.styleField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        return field
    }()
    private lazy var loginBtn: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Вход", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 30
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        return btn
    }()
    private lazy var registerBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Регистрация", for: .normal)
        btn.backgroundColor = lightGreen
        btn.layer.cornerRadius = 30

        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    func addSubviews() {
        view.addSubview(loginBtn)
        view.addSubview(registerBtn)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(errorLabel)
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let token = AuthManager.shared.accessToken{
            let vc = AuthorizedProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
            print(token)
        } else {
            print("No token yet")
        }
    }
    
    func configureConstraints() {
        configureLoginButton()
        configureRegisterButton()
        configureLoginField()
        configurePasswordField()
        configureErrorLabel()
    }
    
    func configureErrorLabel() {
        NSLayoutConstraint.activate([errorLabel.bottomAnchor.constraint(equalTo: self.loginBtn.topAnchor, constant: -10),
                                     errorLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),errorLabel.heightAnchor.constraint(equalToConstant: 50), errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureLoginButton() {
        NSLayoutConstraint.activate([loginBtn.bottomAnchor.constraint(equalTo: self.registerBtn.topAnchor, constant: -10), loginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
                                     loginBtn.heightAnchor.constraint(equalToConstant: 60), loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor), loginBtn.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10)])
        
       
    }
    func configureRegisterButton() {
        NSLayoutConstraint.activate([registerBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),registerBtn.widthAnchor.constraint(equalTo: loginBtn.widthAnchor), registerBtn.heightAnchor.constraint(equalTo: loginBtn.heightAnchor), registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
       
    }
    func configureLoginField() {
        NSLayoutConstraint.activate([loginField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30), loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor), loginField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),loginField.heightAnchor.constraint(equalToConstant: 50)])
    }
    func configurePasswordField() {
        NSLayoutConstraint.activate([passwordField.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: 10), passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor), passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),passwordField.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func validateFields() -> String? {
        
        if loginField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Заполните все поля"
        }
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if Utilities.isPasswordValid(cleanedPassword) == false {
//            return "Пароль недостаточно безопасен"
//        }
        return nil
    }
    
    @objc func didTapSignIn() {
        let error = validateFields()
        if error != nil {
            showError(error!)
            return
        }
        errorLabel.alpha = 0


        AuthManager.shared.logIn(login: loginField.text!, password: passwordField.text!) { [weak self]success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
        completionHandler = {[weak self]success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        
    }
    
    private func handleSignIn(success: Bool){
    //Log user in or log error if didn't log in
        guard success else {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Неверный логин или пароль",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Еще раз", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC,animated: true)
    }
    
    func showError(_ errorText: String) {
        errorLabel.text = errorText
        errorLabel.alpha = 1
    }
    @objc func didTapSignUp() {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: false)
        
    }
    

    
    

}
