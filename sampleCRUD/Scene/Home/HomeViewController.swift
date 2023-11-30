//
//  HomeViewController.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 30/10/23.
//

import Foundation
import UIKit
import RxSwift

protocol HomeDisplayLogic: AnyObject {
    func showErrorMessage(error: String)
    func displayHome()
}

enum State {
case loading, success
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let menu = ["image slider", "populer", "recently"]
    private var header: PageControlFooterView = PageControlFooterView()
    var centerCell: BannerCollectionViewCell?
    var isHorizontalScrollingEnabled: Bool = false
    var numberOfItems = 1000
    private let uniqueId = ["1", "2", "3", "4"]
    var deleteDelegate: DeleteCell?
    var state: State?
    
    lazy var filterHeaderView: HeaderViewCell = {
        let filter = HeaderViewCell()
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.isHidden = true
        return filter
    }()
    
    func displayHome() {
        
    }
    
    func showErrorMessage(error: String) {
        
    }
    
    override func viewDidLoad() {
        getApi().subscribe(onSuccess: { (result) in
            print(result)
        }, onFailure: { (err) in
            print(err)
        }).disposed(by: disposeBag)
        state = .loading
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .success
            self.collectionView.reloadSections(IndexSet(integer: 3))
        }
    }
    
    func setup() {
        title = "Home"
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.cellIdentifier)
        collectionView.register(GridlayoutSectionCollectionViewCell.self, forCellWithReuseIdentifier: GridlayoutSectionCollectionViewCell.cellIdentifier)
        collectionView.register(PageControlFooterView.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: PageControlFooterView.footerIdentifier)
        collectionView.register(BlankFooterViewCell.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: BlankFooterViewCell.footerIdentifier)
        collectionView.register(VerticalLayoutViewCell.self, forCellWithReuseIdentifier: VerticalLayoutViewCell.cellIdentifier)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: HeaderViewCell.headerIdentifier)
        collectionView.register(ListSectionViewCell.self, forCellWithReuseIdentifier: ListSectionViewCell.cellIdentifier)
        collectionView.register(LoadingViewCell.self, forCellWithReuseIdentifier: LoadingViewCell.cellIdentifier)
        for id in uniqueId {
            collectionView.register(ChipHeaderViewCell.self, forSupplementaryViewOfKind: id, withReuseIdentifier: ChipHeaderViewCell.headerIdentifier)
        }
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCompositionalLayout()
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            case 1: return self.gridlayoutSection()
            case 2: return self.horizontalScrollSection()
            default: return self.fourthSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize) // Whithout badge
        item.contentInsets = .init(top: 15, leading: 0, bottom: 15, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Footer", alignment: .bottom)
            
        ]
        section.orthogonalScrollingBehavior = .groupPaging
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            let pageWidth = env.container.contentSize.width
            let currentPage = Int((offset.x / pageWidth).rounded())
            let page = round(offset.x / self.view.bounds.width)
            header.config(page: Int(page) % bannerMokup.count)
        }
        
        return section
    }
    
    private func gridlayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: item, count: 3)
        group.interItemSpacing = .fixed(CGFloat(10))
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        return section
    }
    
    private func horizontalScrollSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func fourthSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        for id in uniqueId {
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: id, alignment: .top)
            headerElement.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [
                headerElement
            ]
            print(id)
        }
        
        return section
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let indexpath = IndexPath(row: Int(Int16.max)/2, section: 0)
        collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
    }
    
    func getApi() -> Single<String> {
        return Provider.rx.request(.BannerMovie(params: Banner.Request(page: 1))).map{ moyaResponse -> String in
            print(moyaResponse.data.toJSON())
//            if moyaResponse.statusCode == 200 {
//                let response = try! JSONDecoder().decode(String.self, from: moyaResponse.data)
//              print(moyaResponse)
//              return response
//            }
//            throw AppError.serverError
            return ""
            
        }
        
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ChipHeaderViewDelegate, DeleteCell {
    
    func onClickDelete(indexPath: IndexPath) {
        bannerMokup.remove(at: indexPath.item)
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
    
    func onClickButton(message: String) {
//        bannerMokup.removeSubrange(bannerMokup.count - 5..<bannerMokup.count)
//        collectionView.performBatchUpdates({
//            bannerMokup.remove(at: 1)
//            collectionView.deleteItems(at: [IndexPath(item: 1, section: 3)])
////            collectionView.reloadItems(inSection: 3)
//        }, completion: nil)
//        for i in bannerMokup.count - 5..<bannerMokup.count {
//            bannerMokup.remove(at: i)
//            collectionView.deleteItems(at: [IndexPath(item: i, section: 3)])
//        }
//        bannerMokup.remove(at: 0)
//        collectionView.deleteItems(at: [IndexPath(item: 0, section: 3)])
//        deleteDelegate = self
//        collectionView.deleteItems(at: [IndexPath(item: 0, section: 3)])
        
        switch message {
        case "1":
            state = .loading
            banner.remove(at: 0)
            collectionView.performBatchUpdates({
                state = .success
                collectionView.deleteItems(at: [IndexPath(item: 0, section: 3)])
            })
        default:
            banner.append(BannerModel(image: "image_banner"))
            collectionView.performBatchUpdates({
                collectionView.insertItems(at: [IndexPath(item: 0, section: 3)])
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return Int(Int16.max)
        case 1 :
            return bannerMokup.count
        case 2 :
            return bannerMokup.count
        default:
            switch state {
            case .loading :
                return 1
            default:
                return banner.count
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.cellIdentifier, for: indexPath) as? BannerCollectionViewCell else {fatalError("Unable deque cell...")}
            cell.cellData = bannerMokup[indexPath.row % bannerMokup.count]
            return cell
            
        case 1 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridlayoutSectionCollectionViewCell.cellIdentifier, for: indexPath) as? GridlayoutSectionCollectionViewCell else {fatalError("Unable deque cell...")}
            cell.cellData = bannerMokup[indexPath.row]
            return cell
        case 2 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalLayoutViewCell.cellIdentifier, for: indexPath) as? VerticalLayoutViewCell else {fatalError("Unable deque cell...")}
            cell.cellData = bannerMokup[indexPath.row]
            return cell
            
        default:
            switch state {
            case .loading:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingViewCell.cellIdentifier, for: indexPath) as? LoadingViewCell else {fatalError("Unable deque cell...")}
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListSectionViewCell.cellIdentifier, for: indexPath) as? ListSectionViewCell else {fatalError("Unable deque cell...")}
                cell.cellData = banner[indexPath.row]
                return cell
            }
            
            

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BannerCollectionViewCell {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.bannerImage.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BannerCollectionViewCell {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn) {
                cell.bannerImage.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Footer" {
            switch indexPath.section {
            case 0:
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PageControlFooterView.footerIdentifier, for: indexPath) as! PageControlFooterView
                return header
            default:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BlankFooterViewCell.footerIdentifier, for: indexPath) as! BlankFooterViewCell
                return footer
            }
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ChipHeaderViewCell.headerIdentifier, for: indexPath) as! ChipHeaderViewCell
            header.chipDelegate = self
            return header
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 160)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

//            let indexPath = IndexPath(row: 0, section: section)
//        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: ChipHeaderViewCell.headerIdentifier, at: indexPath)
//            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),withHorizontalFittingPriority: .r*/equired, verticalFittingPriority: .fittingSizeLevel)
//        }
        
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offestY = scrollView.contentOffset.y
        if abs(offestY) > 600 {
            filterHeaderView.isHidden = false
            filterHeaderView.isSticky = true
        }else {
            filterHeaderView.isHidden = true
            filterHeaderView.isSticky = false
        }
    }
}
