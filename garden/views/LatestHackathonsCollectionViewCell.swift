//
//  LatestHackathonsCollectionViewCell.swift
//  template
//
//  Created by Михаил Исаченко on 28.05.2021.
//

import UIKit
import SDWebImage
class LatestHackathonsCollectionViewCell: UICollectionViewCell {
    static let identifier = "LatestHackathonsCollectionViewCell"
    let lightGreen = UIColor(rgb: 0x43dfa8)

    private let hackathonCover: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "photo")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.addBlurToView()
        //img.layer.cornerRadius = 20
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private let hackathonTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let hackathonDate: UILabel = {
        let label = UILabel()
        //label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = lightGreen
        contentView.addSubview(hackathonCover)
        contentView.addSubview(hackathonTitle)
        contentView.addSubview(hackathonDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //hackathonTitle.sizeToFit()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true

        NSLayoutConstraint.activate([hackathonCover.topAnchor.constraint(equalTo: self.topAnchor), hackathonCover.bottomAnchor.constraint(equalTo: self.bottomAnchor),hackathonCover.rightAnchor.constraint(equalTo: self.rightAnchor),hackathonCover.leftAnchor.constraint(equalTo: self.leftAnchor)])
        
        NSLayoutConstraint.activate([hackathonDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 50), hackathonDate.bottomAnchor.constraint(equalTo: self.hackathonTitle.topAnchor, constant: -10),hackathonDate.rightAnchor.constraint(equalTo: self.rightAnchor),hackathonDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)])
        NSLayoutConstraint.activate([hackathonTitle.topAnchor.constraint(equalTo: self.hackathonDate.bottomAnchor, constant: 10),hackathonTitle.rightAnchor.constraint(equalTo: self.rightAnchor),hackathonTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)])
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        hackathonTitle.text = nil
        hackathonCover.image = nil
    }
    
    func configure(with viewModel:LatestHackathonsCollectionViewModel) {
        hackathonTitle.text = viewModel.title
        hackathonCover.sd_setImage(with: viewModel.hackathonImage, completed: nil)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        hackathonDate.text = formatter.string(from: viewModel.date)
        
    }
}
