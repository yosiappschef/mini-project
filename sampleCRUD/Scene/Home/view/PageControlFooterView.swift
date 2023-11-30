//
//  PageControlFooterView.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 01/11/23.
//

import Foundation
import UIKit

class PageControlFooterView: UICollectionReusableView {
    //MARK: Properties
        static let footerIdentifier = "DividerFooterView"
        
        lazy var footer: UIPageControl = {
            let f = UIPageControl()
            f.translatesAutoresizingMaskIntoConstraints = false
//            f.backgroundColor = .label.withAlphaComponent(0.8)
            f.isUserInteractionEnabled = true
            f.currentPageIndicatorTintColor = .green
            f.pageIndicatorTintColor = .red
            f.currentPage = 0
            f.numberOfPages = bannerMokup.count
            return f
        }()
        
        //MARK: Main LifeCycle
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(footer)
            setUpConstrains()
        }
    
//    func initPage(totalPage: Int){
//        footer.numberOfPages = totalPage
//    }
    func config(page:Int){
        footer.currentPage = page
    }
        
        func setUpConstrains(){
            NSLayoutConstraint.activate([
                footer.leadingAnchor.constraint(equalTo: leadingAnchor),
                footer.trailingAnchor.constraint(equalTo: trailingAnchor),
                footer.heightAnchor.constraint(equalToConstant: 2),
                footer.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
}
