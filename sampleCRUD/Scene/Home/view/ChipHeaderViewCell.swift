//
//  ChipHeaderViewCell.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 13/11/23.
//

import Foundation
import UIKit
import RxSwift
import SwiftUI

protocol ChipHeaderViewDelegate: AnyObject {
    func onClickButton(message: String)
}

class ChipHeaderViewCell: UICollectionReusableView, UIScrollViewDelegate {
    static let headerIdentifier = "ChipHeaderView"
    private let uniqueId = ["1", "2", "3", "4", "5", "6", "7", "8"]
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var selectedButton = 0
    weak var chipDelegate: ChipHeaderViewDelegate?
    //    var observable: Observable<Any>?
    
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 60))
        s.translatesAutoresizingMaskIntoConstraints = false
        s.alwaysBounceHorizontal = true
        s.showsHorizontalScrollIndicator = false
        return s
    }()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        backgroundColor = .cyan
        s.spacing = 10
        return s
    }()
    
    lazy var button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.setTitle("dfsffdfdfdfdfdfdfdfdf", for: .normal)
        b.backgroundColor = .green
        return b
    }()
    
    func setTittle(title: String){
        button.setTitle(title, for: UIControl.State.normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        scrollView.canCancelContentTouches = true
        scrollView.panGestureRecognizer.delaysTouchesBegan = true
        backgroundColor = .red
        addSubview(scrollView)
        for id in uniqueId {
            let button = UIButton()
            button.tag = Int(id) ?? 0
//            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.darkGray
            button.setTitle("\(id)", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControl.Event.touchUpInside)
            
            button.frame = CGRect(x: xOffset, y: buttonPadding - 5, width: 70, height: 30)
            let observable = Observable.merge(button.rx.tap.map({button}))
            observable.subscribe(onNext: { btn in
                for view in self.scrollView.subviews {
                    guard let fo = view as? UIButton else { return }
                    if fo.tag == btn.tag {
                        fo.backgroundColor = .brown
                        self.chipDelegate?.onClickButton(message: String(fo.tag))
                    } else {
                        fo.backgroundColor = .darkGray
                    }
                }
            }).disposed(by: disposeBag)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            let contentOffsetX = (scrollView.contentSize.width/2) - (bounds.width/2)
                    let contentOffsetY = (scrollView.contentSize.height/2) - (bounds.height/2)

                    scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: contentOffsetY), animated: true)
            scrollView.addSubview(button)
            
        }
        
        scrollView.contentSize = CGSize(width: xOffset, height: 1.0)
        setUpConstrains()
    }
    
    @objc func btnTouch(sender: UIButton!){
        //        if sender.tag == 1 {
        //            sender.rx.
        //        } else if sender.tag == 2 {
        //            print(sender.tag)
        //        }
    }
    
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            //            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            //            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            //            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            //            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            //            button.heightAnchor.constraint(equalToConstant: 20),
            //            button.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
