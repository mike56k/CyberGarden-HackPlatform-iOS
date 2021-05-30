//
//  ViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit
enum BrowseSectionType {
    case latestHackathons(viewModels: [LatestHackathonsCollectionViewModel])
    case otherHackathons(viewModels: [LatestHackathonsCollectionViewModel])
    var title: String{
        switch self{
        case .latestHackathons:
            return "Ваши хакатоны"
        case .otherHackathons:
            return "Другие хакатоны"
        }}
}
class HomeViewController: UIViewController, UISearchBarDelegate {
    let lightGreen = UIColor(rgb: 0x43dfa8)
    private var myHacks: [Hack] = []
    private var otherHacks: [Hack] = []
    private var sections = [BrowseSectionType]()
    private lazy var collectionView: UICollectionView = {
    let cv = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout{sectionIndex, _ -> NSCollectionLayoutSection? in
            return Self.createSectionLayout(section: sectionIndex)
        }
    )
    return cv
    }()
    
    private lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
            s.placeholder = "Введите название хакатона"
            s.delegate = self
            //s.tintColor = .white
            //s.barTintColor = // color you like
            s.barStyle = .default
            s.sizeToFit()
        return s
    }()
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = lightGreen
        
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(
            
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .black

        configureCollectionView()
        fetchData()

    }
    

    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(LatestHackathonsCollectionViewCell.self, forCellWithReuseIdentifier: LatestHackathonsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TitleHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,
                                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.register(OtherHackathonsCollectionViewCell.self,
                                forCellWithReuseIdentifier: OtherHackathonsCollectionViewCell.identifier)
    }
    
//    func fetchData() {
//        sections.append(.otherHackathons)
//        sections.append(.latestHackathons(viewModels: []))
//    }
    
    private func fetchData(){
        // Use Dispatch group: This helps to group multiple concurrent operations
        let group = DispatchGroup()
        group.enter()
      //  group.enter()
        
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening

            // then remove the spinner view controller
            child.willMove(toParent: nil)
           
        
        
        
            
           // Code you want to be delayed
            var myHacksResponce: [Hack]?
            var otherHacksResponce: [Hack]?


            APICaller.shared.getAllHacks { result in
                defer{
                    group.leave()
                }
                switch result{
                case .success(let model):
                    print("This is model")
                    print(model)
                    myHacksResponce = model
                    otherHacksResponce = model
                    break
                case .failure(let error):
                    print("This is error")

                    print(error.localizedDescription)
                    break
                }
            }
            child.view.removeFromSuperview()
            child.removeFromParent()

            group.notify(queue: .main) {
                // Unwrap the optional responses
                guard let myHacksModels = myHacksResponce,
                      let otherHacksModels = otherHacksResponce else {
                    return
                }
                self.configureModels(myHacks: Array(myHacksModels[0..<6]), otherHacks: Array(otherHacksModels[6...17]))
             }
            // Section2: Featured Playlists
        
        
        

    }
    private func configureModels(
        myHacks: [Hack],
        otherHacks: [Hack]
    ){
        self.myHacks = myHacks
        self.otherHacks = otherHacks
        //print(otherHacks)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //let date = dateFormatter.date(from:isoDate)!
        //Configure models with compactMap to return viewModels
        sections.append(.latestHackathons(viewModels: myHacks.compactMap({
            return LatestHackathonsCollectionViewModel(
                title: $0.name!, hackathonImage: URL(string: $0.image ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Junction_2015.jpg/1200px-Junction_2015.jpg"), date: dateFormatter.date(from: $0.start_date!)!
                )
        })))
        sections.append(.otherHackathons(viewModels: otherHacks.compactMap({return LatestHackathonsCollectionViewModel(title: $0.name!, hackathonImage: URL(string: $0.image ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Junction_2015.jpg/1200px-Junction_2015.jpg"), date: dateFormatter.date(from: $0.start_date!)!)})))

        
            self.collectionView.reloadData()
        
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type{
        case .latestHackathons(let viewModels):
            return viewModels.count
        case .otherHackathons(let viewModels):
            return viewModels.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section{
        case .latestHackathons:
            let hack = myHacks[indexPath.row]
            let vc = HackathonInfoViewController(hack: hack)
            vc.title = hack.name
            vc.navigationItem.largeTitleDisplayMode = .always
            navigationController?.pushViewController(vc, animated: false)
        case .otherHackathons:
            print(indexPath.row)
            let hack = otherHacks[indexPath.row]
            let vc = HackathonInfoViewController(hack: hack)
            vc.navigationItem.largeTitleDisplayMode = .always
            
            navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
                for: indexPath
        ) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else{
            print("here")
            return UICollectionReusableView()
        }
        let section = indexPath.section
        let title = sections[section].title
        

        header.configure(with: title)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        print()
        print("Sections")
        print(sections)
        print()
        switch type{
        case .latestHackathons(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LatestHackathonsCollectionViewCell.identifier,
                    for: indexPath) as? LatestHackathonsCollectionViewCell else {
               return UICollectionViewCell()
            }
            DispatchQueue.global().async {
                let viewModel = viewModels[indexPath.row]

                DispatchQueue.main.async {
                    cell.configure(with: viewModel)

                }
            }
            
            
            
            return cell
        case .otherHackathons(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OtherHackathonsCollectionViewCell.identifier,
                    for: indexPath) as? OtherHackathonsCollectionViewCell else {
               return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
        }


    }
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
        
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        switch section {
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400)),subitem: item, count: 3)
            
            let horisontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(400)), subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horisontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews

            return section
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .absolute(250)),subitem: item, count: 1)
            
            let horisontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .absolute(250)), subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horisontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews

            return section
        case 1:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1.0)))
            // Add padding between items
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)),
                    subitem: item,
                    count: 1)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400)),subitem: item, count: 3)
            
            let horisontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(400)), subitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horisontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        }
        
        
    }
    
    
}
