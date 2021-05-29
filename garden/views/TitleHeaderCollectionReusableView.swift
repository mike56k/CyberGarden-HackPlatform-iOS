//
//  TitleHeaderCollectionReusableView.swift
//  template
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
private let label: UILabel = {
   let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 22, weight: .regular)
    return label
}()
//Init
override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addSubview(label)
}
required init?(coder: NSCoder) {
    fatalError()
}
override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = CGRect(x: 15, y: 0, width: self.bounds.width-30, height: self.bounds.height)
}
func configure(with title: String){
    label.text = title
}
}
