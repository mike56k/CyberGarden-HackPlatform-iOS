//
//  OtherHackathonsCollectionViewCell.swift
//  garden
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit

class OtherHackathonsCollectionViewCell: UICollectionViewCell {
    static let identifier = "OtherHackathonsCollectionViewCell"
    
    private let hackathonCover: UIImageView = {
        let imageView = UIImageView()
        imageView.addBlurToView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let hackathonTitle: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    private let hackathonDate: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(hackathonCover)
        contentView.addSubview(hackathonTitle)
        contentView.addSubview(hackathonDate)
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    //Function: layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        //hackathonTitle.sizeToFit()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        NSLayoutConstraint.activate([hackathonCover.topAnchor.constraint(equalTo: self.topAnchor), hackathonCover.bottomAnchor.constraint(equalTo: self.bottomAnchor),hackathonCover.rightAnchor.constraint(equalTo: self.rightAnchor),hackathonCover.leftAnchor.constraint(equalTo: self.leftAnchor)])
        NSLayoutConstraint.activate([hackathonTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20), hackathonTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor), hackathonTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 )])
        NSLayoutConstraint.activate([hackathonDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20), hackathonDate.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        hackathonTitle.text = nil
        hackathonCover.image = nil
        hackathonDate.text = nil
    }
    
    func configure(with viewModel: LatestHackathonsCollectionViewModel){
        hackathonTitle.text = viewModel.title
        hackathonCover.sd_setImage(with: viewModel.hackathonImage, completed: nil)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        hackathonDate.text = formatter.string(from: viewModel.date)
    }
}
