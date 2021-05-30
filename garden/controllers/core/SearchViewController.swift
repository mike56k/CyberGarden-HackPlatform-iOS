//
//  SearchViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit
import CollectionViewPagingLayout

class SearchViewController: UIViewController, UICollectionViewDataSource {
    var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .systemBackground
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            let layout = CollectionViewPagingLayout()
            collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
            collectionView.isPagingEnabled = true
            collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.dataSource = self
            collectionView.backgroundColor = .systemBackground
            collectionView.showsHorizontalScrollIndicator = false

            view.addSubview(collectionView)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            4
        }
    let tempUsers = [["Mike Isachenko", "Dmitriy Din", "Anastasia Gisina"],["Mike Isachenko", "Komlev Danila", "Arseniy Ivanov"],["John Brown", "Mike Isachenko", "Ben Awad"],["Jake Pams", "Jeremy Joke", "Sam Boiler", "Vasya Green"]]
    let tempTitles = ["Garden Masters", "uNext", "Imaginary Team", "CrazyNuggets"]
    let tempLogos = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmg6VbQr7k4bE8m1sGjODK19nEZn-UKVChBg&usqp=CAU", "https://avatars.githubusercontent.com/u/78881465?s=400&u=a31449a0365076d11a3c0d9942cde760bda00023&v=4", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR34dyR4PdRqvfNi_QIruoGyjHihGJrL98VuA&usqp=CAU","https://transmillecalibration.com/wp-content/themes/arkahost/assets/images/default-680x600.jpg"]
    
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
            
            
            
            print(tempTitles[indexPath.item])
            cell.configure(members: tempUsers[indexPath.item], mytitle: tempTitles[indexPath.item], logo: tempLogos[indexPath.item])
            return cell
            
            
        }

}


