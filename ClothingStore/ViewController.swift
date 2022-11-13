//
//  ViewController.swift
//  ClothingStore
//
//  Created by Mindy Douglas on 11/7/22.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout =
    {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[sectionIndex].type
            
            
            switch sectionType {
            
            case .header:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(320), heightDimension: .absolute(37))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(53))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case .large:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88), heightDimension: .fractionalHeight(0.57))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
//            case .ad:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
//                let itemCount = snapshot.numberOfItems(inSection: snapshot.sectionIdentifiers[sectionIndex])
//                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(itemCount * 88) + 8), heightDimension: .fractionalHeight(1))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPaging
//                return section
                
            case .ad:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
                let itemCount = snapshot.numberOfItems(inSection: snapshot.sectionIdentifiers[sectionIndex])
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.27), heightDimension: .fractionalHeight(0.15))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
            case .rating:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88), heightDimension: .fractionalHeight(0.58))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
            default: return nil
            }
        }
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       initialize()
       navigationSetup()
    }
    
    func navigationSetup() {
        title = "Clothing Store"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
    
    
    func initialize() {
        setupCollectionView()
        configureDataSource()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "LargeCell", bundle: .main), forCellWithReuseIdentifier: "LargeCell")
        collectionView.register(UINib(nibName: "AdCell", bundle: .main), forCellWithReuseIdentifier: "AdCell")
        collectionView.register(UINib(nibName: "RatingCell", bundle: .main), forCellWithReuseIdentifier: "RatingCell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: .main), forCellWithReuseIdentifier: "HeaderCell")
        
        collectionView.collectionViewLayout = collectionViewLayout
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView,indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case.header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
                return cell
            case.large:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCell", for: indexPath)
                return cell
            case .ad:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath)
                return cell
            case .rating:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingCell", for: indexPath)
                return cell
            default: return nil
            }
        }
        let sections = [
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item()
            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item(),

            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .ad, items: [
                Item(), Item(), Item(), Item(), Item(), Item(), Item()
            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item(),
            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .rating, items: [
                Item(), Item(), Item()
            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item()
            ]),
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item(),
            ])
        ]
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

