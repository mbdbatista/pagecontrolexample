//
//  CustomPageControl.swift
//  ScrollView
//
//  Created by Matheus Donizete Batista on 16/08/20.
//  Copyright © 2020 Matheus Donizete Batista. All rights reserved.
//

import UIKit
class CustomPageControl: UIStackView {
    private let dotSize = CGFloat(10)
    private let dotSpacing = CGFloat(2)
    private var dots: [UIView] = []

    @IBInspectable var numberOfPages: Int = 0 {
        didSet {
            createView()
        }
    }

    @IBInspectable var currentPage: CGFloat = 0 {
        didSet {
            currentPageRounded = Int(round(currentPage))
            updateView()
        }
    }

    fileprivate var currentPageRounded: Int = 0


    fileprivate func createView() {
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = dotSpacing
        self.axis = .horizontal
        for index in 0 ..< numberOfPages {
            let view = UIView()
            let widthConstraint = generateWidthConstraint(
                view: view,
                size: dotSize,
                index: index)
            let heightConstraint = generateHeightConstraint(
                view: view,
                size: dotSize,
                index: index)
            view.addConstraint(widthConstraint)
            view.addConstraint(heightConstraint)
            view.layer.cornerRadius = dotSize / 2
            view.layer.masksToBounds = true
            view.backgroundColor = index == currentPageRounded ? .blue : .yellow
            dots.append(view)
            self.addArrangedSubview(view)
        }
        let widthConstraint = self.constraints.first(where: {
            $0.firstAttribute == .width
        })
        widthConstraint?.constant = (CGFloat(numberOfPages + 3) * dotSize) + (CGFloat(numberOfPages - 1) * dotSpacing)
        self.updateConstraints()
        self.layoutIfNeeded()
    }


    fileprivate func updateView() {
        for index in 0 ..< numberOfPages {
            let view = dots[index]
            view.backgroundColor = index == currentPageRounded ? .blue : .yellow
            let widthConstraint = view.constraints.first(where: {
                $0.firstAttribute == .width
            })
            widthConstraint?.constant = currentPageRounded == index ? (dotSize * 3) : dotSize
//            view.updateConstraints()
//            view.layoutIfNeeded()
        }
        self.updateConstraints()
        self.layoutIfNeeded()
        print(currentPage)
    }

    fileprivate func generateHeightConstraint(view: UIView, size: CGFloat,  index: Int) -> NSLayoutConstraint {
        return NSLayoutConstraint(
        item: view,
        attribute: NSLayoutConstraint.Attribute.height,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: nil,
        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
        multiplier: 1,
        constant: size)
    }

    fileprivate func generateWidthConstraint(view: UIView, size: CGFloat, index: Int) -> NSLayoutConstraint {
        let realSize = currentPageRounded == index ? size * 3 : size
        return NSLayoutConstraint(
        item: view,
        attribute: NSLayoutConstraint.Attribute.width,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: nil,
        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
        multiplier: 1,
        constant: realSize)
    }

    fileprivate func generateCenterConstraint(view: UIView, stackView: UIStackView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
        item: stackView,
        attribute: NSLayoutConstraint.Attribute.centerX,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: view,
        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
        multiplier: 1,
        constant: CGFloat(20))
    }

}
