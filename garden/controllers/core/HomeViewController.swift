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
class HomeViewController: UIViewController {
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
    private let spinner: UIActivityIndicatorView = {
      let spin = UIActivityIndicatorView()
        spin.tintColor = .label
        spin.hidesWhenStopped = true
        
        return spin
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
//        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//                                     collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//
//                                     collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)])
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = lightGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .black
        view.addSubview(spinner)
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

        
        var myHacksResponce: HackathonDetailsResponce?
        var otherHacksResponce: HackathonDetailsResponce?


//        APICaller.shared.getAllHacks { result in
//            defer{
//                group.leave()
//            }
//            switch result{
//            case .success(let model):
//                print("This is model")
//                print(model)
//                myHacksResponce = model
//                otherHacksResponce = model
//                break
//            case .failure(let error):
//                print("This is error")
//
//                print(error.localizedDescription)
//                break
//            }
//        }
        
        myHacksResponce = HackathonDetailsResponce(hacks: [Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: [])])
        otherHacksResponce = HackathonDetailsResponce(hacks: [Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: []),Hack(id: 1, name: "Прорыв", description: "description", start_date: "2016-04-14T10:44:00+0000", image: "https://cdn22.img.ria.ru/images/07e4/05/06/1571020469_0:0:1920:1080_600x0_80_0_0_8492ea5758147feadb42f576ad3ae00c.jpg", url: "", location_lon: 23, location_lat: 5, sponsors: [], tags: [])])
        //print(myHacksResponce)
        //group.notify(queue: .main) {
            // Unwrap the optional responses
            guard let myHacksModels = myHacksResponce?.hacks,
                  let otherHacksModels = otherHacksResponce?.hacks else {
                return
            }
            self.configureModels(myHacks: myHacksModels, otherHacks: otherHacksModels)
         //}
        // Section2: Featured Playlists
        
//        APICaller.shared.getFeaturedPlaylists { result in
//            defer{
//                group.leave()
//            }
//            switch result{
//            case .success(let model):
//                featuredPlaylist = model
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//                break
//            }
//        }
//        // Section3: Recommended Tracks
//        APICaller.shared.getRecommendationGenres{ result in
//            switch result{
//            case .success(let model):
//                let genres = model.genres
//                var seeds = Set<String>()
//                while seeds.count < 5 {
//                    if let random = genres.randomElement(){
//                        seeds.insert(random)
//                    }
//                }
//                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
//                    defer{
//                        group.leave()
//                    }
//                    switch recommendedResult{
//                    case .success(let model):
//                        recommendations = model
//                        break
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                        break
//                    }
//                }
//            case .failure( _): break
//            }
//        }
        //Once no.of group enteries is equal to no.of group leaves
//        group.notify(queue: .main) {
//            // Unwrap the optional responses
//            guard let newAlbums = newReleases?.albums.items,
//                 // let playlists = featuredPlaylist?.playlists.items ,
//                  let tracks = recommendations?.tracks else {
//                return
//            }
//            self.configureModels(newAlbums: newAlbums, playlists: playlists, tracks: tracks)
//    }
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //let date = dateFormatter.date(from:isoDate)!
        //Configure models with compactMap to return viewModels
        sections.append(.latestHackathons(viewModels: myHacks.compactMap({
            return LatestHackathonsCollectionViewModel(
                title: $0.name, hackathonImage: URL(string: $0.image), date: dateFormatter.date(from: $0.start_date)!
                )
        })))
        sections.append(.otherHackathons(viewModels: otherHacks.compactMap({return LatestHackathonsCollectionViewModel(title: $0.name, hackathonImage: URL(string: $0.image), date: dateFormatter.date(from: $0.start_date)!)})))


        collectionView.reloadData()
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
            let vc = HackathonInfoViewController()
            vc.title = hack.name
            vc.navigationItem.largeTitleDisplayMode = .always
            navigationController?.pushViewController(vc, animated: false)
        case .otherHackathons:
            let hack = myHacks[indexPath.row]
            let vc = HackathonInfoViewController()
            vc.title = hack.name
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
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
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
