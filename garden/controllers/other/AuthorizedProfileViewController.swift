//
//  AuthorizedProfileViewController.swift
//  garden
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit

class AuthorizedProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.view.backgroundColor = .systemBackground
        self.title = "Профиль"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
