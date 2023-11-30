//
//  HomeViewController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 28/11/23.
//

import Foundation
import UIKit

class HomeAhaViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    override func viewDidLoad() {
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 80
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.collectionViewLayout = layout
        view.addSubview(collectionView)
        setupConstraint()
        collectionView.register(HomeAhaaViewCell.self, forCellWithReuseIdentifier: HomeAhaaViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeAhaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAhaaViewCell.cellIdentifier, for: indexPath) as? HomeAhaaViewCell else {fatalError("Unable deque cell...")}
        cell.cellData = homeDummy[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 80, height: collectionView.frame.height / 3)
    }
    
}
