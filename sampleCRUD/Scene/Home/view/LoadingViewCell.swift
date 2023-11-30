//
//  LoadingViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 22/11/23.
//

import Foundation
import UIKit

class LoadingViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "LoadingCollectionViewCell"
    
    lazy var loading: UIActivityIndicatorView = {
       var l = UIActivityIndicatorView()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.style = .large
        l.startAnimating()
        return l
    }()
    
    func setupView() {
        addSubview(loading)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
//            loading.topAnchor.constraint(equalTo: topAnchor),
//            loading.bottomAnchor.constraint(equalTo: bottomAnchor),
//            loading.leadingAnchor.constraint(equalTo: leadingAnchor),
//            loading.trailingAnchor.constraint(equalTo: trailingAnchor)
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
