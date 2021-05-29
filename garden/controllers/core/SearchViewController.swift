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
            view.addSubview(collectionView)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            return cell
            
            
        }

}


