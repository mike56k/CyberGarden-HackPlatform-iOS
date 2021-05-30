//
//  HackathonInfoViewController.swift
//  template
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit
import SDWebImage

class HackathonInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let hack: Hack
    private var models = [String]()
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        self.title = formatter.string(from: dateFormatter.date(from: hack.start_date!)!)

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createTableHeader(with: hack.image)
        updateUI()
        tableView.reloadData()

    }
    private func updateUI(){
        models.append(hack.name!)
        models.append(hack.description!)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func createTableHeader(with string: String?){
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width / 2))
        let imageWidth: CGFloat = headerView.bounds.width
        let imageHeight: CGFloat = headerView.bounds.height
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        //Adding corner radius to image
        imageView.layer.masksToBounds = true
        
        tableView.tableHeaderView = headerView
    }
    
    init(hack: Hack) {
        self.hack = hack
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
     
       
    }


   

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()

        let btn = UIButton(frame: CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 35))
        btn.backgroundColor = UIColor(rgb: 0x43dfa8)
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        btn.setTitle("Пойду", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(didTapWantToParticipate), for: .touchUpInside)

        
        
             let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 5, width: tableView.frame.width - 20, height: 30))
             segmentedControl.insertSegment(withTitle: "One", at: 0, animated: false)
             segmentedControl.insertSegment(withTitle: "Two", at: 1, animated: false)
             segmentedControl.insertSegment(withTitle: "Three", at: 2, animated: false)
             v.addSubview(btn)
             return v
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.font =  .systemFont(ofSize: 22, weight: .bold)
        }
        cell.textLabel?.text = models[indexPath.row]
        cell.textLabel?.numberOfLines = -1
        cell.selectionStyle = .none
        return cell
    }
    @objc func didTapWantToParticipate() {
        let vc = SuccessHackRegistrationViewController()
        
        //vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
