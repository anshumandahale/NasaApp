//
//  DetailViewController.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 21/10/22.
//

import UIKit
import SwiftInfiniteScrollView
import RxSwift
import RxCocoa

class DetailViewController<ViewModel: DetailVM>: UIViewController, LCInfiniteScrollViewDelegate, ViewType {
    var images: Nasa?
    var selectedImageIndex: Int = 0
    let viewModel: ViewModel
    let nib: String
    let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
    
    var infiniteScrollView: LCInfiniteScrollView?
    let backActionSubject = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    required init(viewModel: ViewModel, nib: String) {
        self.viewModel = viewModel
        self.nib = nib
        super.init(nibName: nib, bundle: Bundle.main)
        bind(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(output: ViewModel.Output) {
        Driver.combineLatest(output.images, output.selectedIndex)
            .drive(onNext: { [weak self] images, selectedIndex in
                self?.selectedImageIndex = selectedIndex
                self?.images = images
            })
            .disposed(by: disposeBag)
    }
    
    func input() -> ViewModel.Input {
        ViewModel.Input(
            willAppear: rx.viewWillAppear.asDriver(),
            backButtonTapped: self.newBackButton.rx.tap.asDriver()
        )
    }
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infiniteScrollView = LCInfiniteScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        infiniteScrollView!.delegate = self
        infiniteScrollView!.autoScroll = false
        self.view.addSubview(infiniteScrollView!)
    }
    
    func numberOfIndexes(in infiniteScrollView: LCInfiniteScrollView) -> Int {
        return images?.count ?? 0
    }
    
    func infiniteScrollView(_ infiniteScrollView: LCInfiniteScrollView, displayReusableView view: UIView, forIndex index: Int) {
        let detail = view as! DetailContainerView
        guard let image = images?[index] else { return }
        detail.setupWithImage(image: image)
    }
    
    func reusableView(in infiniteScrollView: LCInfiniteScrollView) -> UIView {
        UINib.init(nibName: R.nib.detailContainerView.name, bundle: .main).instantiate(withOwner: self, options: nil)[0] as! DetailContainerView
    }
}
