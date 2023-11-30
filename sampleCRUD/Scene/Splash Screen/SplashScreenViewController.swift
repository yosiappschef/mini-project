//
//  SplashScreenViewController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 23/11/23.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController {
    let sandYellow: UIColor = {
        return UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    }()
    let sandBottom: UIColor = {
        return UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }()
    
    let gradient: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0), UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)]
        grad.locations = [0.0, 1.0]
        return grad
    }()
    
    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
//        cv.collectionViewLayout = layout
//        cv.clipsToBounds = true
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0), UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = cv.bounds
//        cv.layer.insertSublayer(gradientLayer, at: 0)
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
        pc.pageIndicatorTintColor = UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
        return pc
    }()
    override func viewDidLoad() {
        view.backgroundColor = .black
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        view.addSubview(collectionView)
        view.addSubview(pageControl)
//        setBackgroundGradient()
        setupConstraint()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(SplashScreenViewCell.self, forCellWithReuseIdentifier: SplashScreenViewCell.cellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [sandYellow, sandBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.collectionView.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension SplashScreenViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return splashDummy.count
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SplashScreenViewCell.cellIdentifier, for: indexPath) as? SplashScreenViewCell else {fatalError("Unable deque cell...")}
        cell.cellData = splashDummy[indexPath.row]
        cell.button.rx.tap.bind { (_) in
            let dest = LoginViewController()
            self.navigationController?.setViewControllers([dest], animated: true)
        }.disposed(by: disposeBag)
        switch indexPath.item {
        case 0:
            cell.buttonVisibility(isVisible: false)
            cell.imageVisibility(isVisible: true)
            cell.applyGradient(colors: [UIColor(red: 251.0 / 255.0, green: 218.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 247.0 / 255.0, green: 107.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0).cgColor])
//            pageControl.currentPageIndicatorTintColor = .ini
        case 1:
            cell.buttonVisibility(isVisible: false)
            cell.imageVisibility(isVisible: false)
            cell.backgroundColor = .white
        default:
            cell.buttonVisibility(isVisible: true)
            cell.imageVisibility(isVisible: false)
            cell.backgroundColor = .white
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SplashScreenViewCell.cellIdentifier, for: indexPath) as? SplashScreenViewCell else {fatalError("Unable deque cell...")}
//        cell.button.rx.tap.bind { (_) in
//            let dest = LoginViewController()
//            self.navigationController?.pushViewController(dest, animated: true)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
}
