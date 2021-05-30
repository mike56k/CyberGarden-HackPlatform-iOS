//
//  SuccessHackRegistrationViewController.swift
//  garden
//
//  Created by Михаил Исаченко on 30.05.2021.
//

import UIKit

class SuccessHackRegistrationViewController: UIViewController {
    let lightGreen = UIColor(rgb: 0x43dfa8)

    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        //btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        btn.setTitle("Вернуться на главную", for: .normal)
        btn.setTitleColor(.white, for: .normal)

        btn.addTarget(self, action: #selector(didTapGoBack), for: .touchUpInside)

        return btn
    }()
    private lazy var messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.backgroundColor = lightGreen
        label.text = "Вы зарегистрированы!"

        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubview(backButton)
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), backButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100), backButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6), backButton.heightAnchor.constraint(equalToConstant: 50)])
        NSLayoutConstraint.activate([messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), messageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), messageLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor), messageLabel.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    @objc func didTapGoBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
