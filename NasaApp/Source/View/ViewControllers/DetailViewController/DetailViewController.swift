//
//  DetailViewController.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 21/10/22.
//

import UIKit
import SwiftInfiniteScrollView

class DetailViewController: UIViewController, LCInfiniteScrollViewDelegate {
    
    let images: Nasa = Nasa()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let banner = LCInfiniteScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
        banner.delegate = self
        banner.autoScroll = true
        self.view.addSubview(banner)
    }
    
    func numberOfIndexes(in infiniteScrollView: LCInfiniteScrollView) -> Int {
        return images.count
    }
    
    func infiniteScrollView(_ infiniteScrollView: LCInfiniteScrollView, displayReusableView view: UIView, forIndex index: Int) {
        let detail = view as! DetailContainerView
        detail.setupWithImage(image: images[index])
    }
    
    func reusableView(in infiniteScrollView: LCInfiniteScrollView) -> UIView {
        UINib.init(nibName: R.nib.detailContainerView.name, bundle: .main).instantiate(withOwner: self, options: nil)[0] as! DetailContainerView
    }
}
