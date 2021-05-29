//
//  AuthorizedProfileViewController.swift
//  garden
//
//  Created by Михаил Исаченко on 29.05.2021.
//
import SDWebImage

import UIKit

class AuthorizedProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.view.backgroundColor = .systemBackground
        self.title = "Профиль"

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = .systemBackground
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.updateUI(with: model)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                    break
                }
            }
        }
    }
    //Function: updateUI
    private func updateUI(with model: UserProfile){
        tableView.isHidden = false
        // Configure table models
        if let fio = model.fio {
            models.append("Имя: \(fio)")
        }

        models.append("E-mail: \(model.email)")


        createTableHeader(with: "https://123tlumacz.pl/wp-content/uploads/2014/08/photodune-2360811-computer-programmer-s.jpg")
        tableView.reloadData()
    }
    //Function: createTableHeader
    private func createTableHeader(with string: String?){
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width / 1.5))
        let imageSize: CGFloat = headerView.bounds.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        //Adding corner radius to image
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        tableView.tableHeaderView = headerView
    }
    //Function: failedToGetProfile
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Не удалось загрузить профиль"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
