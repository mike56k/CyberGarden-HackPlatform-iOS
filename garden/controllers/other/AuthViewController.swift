//
//  AuthViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit

class AuthViewController: UIViewController {
    let lightGreen = UIColor(rgb: 0x43dfa8)
    let white = UIColor.white

    private lazy var registerBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Готово", for: .normal)
        btn.backgroundColor = lightGreen
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 30

        //btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        return btn
    }()
    private lazy var firstName: UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1.0
        field.placeholder = "Имя"
       return field
    }()
    private lazy var secondName: UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1.0
        field.placeholder = "Фамилия"
       return field
    }()
    private lazy var thirdName: UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1.0
        field.placeholder = "Отчество"
       return field
    }()
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
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1.0
        field.placeholder = "Почта"
       return field
    }()
    private lazy var passwordField: UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1.0
    
        field.placeholder = "Пароль"
       return field
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        //navigationItem.b?.tintColor = .black
        self.view.backgroundColor = .systemBackground
        self.title = "Регистрация"
        // Do any additional setup after loading the view.
    }
    func addSubviews() {

        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 16.0
        
        //firstName.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9).isActive = true
       // firstName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(firstName)
        stackView.addArrangedSubview(secondName)
        stackView.addArrangedSubview(thirdName)

        stackView.addArrangedSubview(loginField)
        stackView.addArrangedSubview(passwordField)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        
        
        view.addSubview(registerBtn)

        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        configureConstraints()
    }
    func configureConstraints() {
        

        configureRegisterButton()
//        configureLoginField()
//        configurePasswordField()
//        configureFirstName()
//        configureSecondName()
    }
    func configureRegisterButton() {
        NSLayoutConstraint.activate([registerBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),registerBtn.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), registerBtn.heightAnchor.constraint(equalToConstant: 60), registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
       
    }
    func configureLoginField() {
        NSLayoutConstraint.activate([loginField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),loginField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), loginField.heightAnchor.constraint(equalToConstant: 60), loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    func configurePasswordField() {
        NSLayoutConstraint.activate([passwordField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),passwordField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), passwordField.heightAnchor.constraint(equalToConstant: 60), passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    func configureFirstName() {
        NSLayoutConstraint.activate([firstName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),firstName.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), firstName.heightAnchor.constraint(equalToConstant: 60), firstName.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    func configureSecondName() {
        NSLayoutConstraint.activate([secondName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),secondName.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9), secondName.heightAnchor.constraint(equalToConstant: 60), secondName.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }


}
