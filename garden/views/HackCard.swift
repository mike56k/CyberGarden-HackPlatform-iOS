//
//  HackCard.swift
//  garden
//
//  Created by Михаил Исаченко on 30.05.2021.
//

import UIKit
import CollectionViewPagingLayout
import SDWebImage
class MyCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    let lightGreen = UIColor(rgb: 0x43dfa8)
    
    var members:[String] = []
    
    var mytitle: String = ""
    
    var logo: String = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = members[indexPath.item]
        cell.textLabel?.textAlignment = .center
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    private let tableView: UITableView = {
       let tableView = UITableView()

        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    private  let teamName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private  let inviteLink: UITextField = {
        let field = UITextField()
        //label.font = .systemFont(ofSize: 22, weight: .bold)
        field.textColor = .black
       // label.numberOfLines = 0
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.textColor = .black
        
        return field
    }()
    private  let copyLinkButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        btn.setTitle("Пригласить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/768px-LEGO_logo.svg.png"), completed: nil)
        //Adding corner radius to image
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // The card view that we apply transforms on
    var card: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    func configure(members: [String], mytitle: String, logo: String) {
        self.members = members
        self.mytitle = mytitle
        self.logo = logo
        teamName.text = self.mytitle
        self.logoImageView.sd_setImage(with: URL(string: self.logo), completed: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        // Adjust the card view frame
        // you can use Auto-layout too
        let cardFrame = CGRect(
            x: 80,
            y: 100,
            width: frame.width - 160,
            height: frame.height - 200
        )
        
        card = UIView(frame: cardFrame)
        card.backgroundColor = lightGreen
        
        card.layer.cornerRadius = 10
        contentView.addSubview(card)
        tableView.delegate = self
        tableView.dataSource = self
        card.addSubview(tableView)
        card.addSubview(teamName)
        card.addSubview(logoImageView)
        card.addSubview(copyLinkButton)
        
        teamName.textAlignment = .center
        inviteLink.text = "https://stackoverflow.com/questions/29791644/disabling-user-input-for-uitextfield-in-swift"
        
        print("HERE")
        NSLayoutConstraint.activate([teamName.topAnchor.constraint(equalTo: card.topAnchor, constant: 30), teamName.centerXAnchor.constraint(equalTo: card.centerXAnchor), teamName.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.9)])
        NSLayoutConstraint.activate([logoImageView.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 10), logoImageView.widthAnchor.constraint(equalToConstant: 100), logoImageView.heightAnchor.constraint(equalToConstant: 100), logoImageView.centerXAnchor.constraint(equalTo: card.centerXAnchor) ])
        NSLayoutConstraint.activate([copyLinkButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -20), copyLinkButton.centerXAnchor.constraint(equalTo: card.centerXAnchor), copyLinkButton.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.8)])
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10), tableView.bottomAnchor.constraint(equalTo: copyLinkButton.topAnchor, constant: -10), tableView.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.8), tableView.centerXAnchor.constraint(equalTo: card.centerXAnchor)])
    }
    
    
}

extension MyCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.invertedCylinder)
    }
}
//extension MyCell: TransformableView {
//    func transform(progress: CGFloat) {
//        let alpha = 1 - abs(progress)
//        contentView.alpha = alpha
//    }
//}
