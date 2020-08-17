//
//  ViewController.swift
//  ScrollView
//
//  Created by Matheus Donizete Batista on 16/08/20.
//  Copyright © 2020 Matheus Donizete Batista. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var customPageControl: CustomPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var onboardingItens: [OnboardingModel]?
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingItens = [
            OnboardingModel(image: "image01", title: "Titulo 01"),
            OnboardingModel(image: "image02", title: "Titulo 02"),
            OnboardingModel(image: "image03", title: "Titulo 03"),
        ]
        setupScrollView()
        setupPageControl()
}

    func setupScrollView() {
        let itensCount = CGFloat(onboardingItens?.count ?? 0)
        let previousWidth = scrollView.frame.width
        let width = scrollView.frame.width * itensCount
        scrollView.delegate = self
        scrollView.contentSize.width = width
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true

        if let onboardingItens = onboardingItens {
            for (index, onboarding) in onboardingItens.enumerated() {
                let imageView = UIImageView()
                let image = UIImage(named: onboarding.image)
                imageView.image = image
                imageView.sizeToFit()
                imageView.frame = CGRect(
                    x: previousWidth * CGFloat(index),
                    y: (scrollView.frame.height / 2) - imageView.frame.height,
                    width: previousWidth,
                    height: imageView.frame.height
                )
                scrollView.addSubview(imageView)
            }
        }
    }

    func setupPageControl() {
        pageControl.numberOfPages = onboardingItens?.count ?? 0
        customPageControl.numberOfPages = onboardingItens?.count ?? 0
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.x / scrollView.frame.width
        let positionRounded = round(position)
        pageControl.currentPage = Int(positionRounded)
        customPageControl.currentPage = position
    }
}

