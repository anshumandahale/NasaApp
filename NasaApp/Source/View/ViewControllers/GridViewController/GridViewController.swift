//
//  GridViewController.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

class GridViewController<ViewModel: GridVM>: UIViewController, ViewType {
    
    private let disposeBag = DisposeBag()
    private let gridSelected = PublishSubject<Int>()
    let viewModel: ViewModel
    let nib: String
    
    required init(viewModel: ViewModel, nib: String) {
        self.viewModel = viewModel
        self.nib = nib
        super.init(nibName: nib, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(output: ViewModel.Output) {
        output.loadImages
            .drive(onNext: { images in
                print("Recieved \(images.count) images")
            })
            .disposed(by: disposeBag)
    }
    
    func input() -> ViewModel.Input {
        ViewModel.Input(
            didLoad: rx.viewDidLoad.asDriver(),
            tappedOnCell: gridSelected.asDriver(onErrorJustReturn: 1)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Grid"
    }
    
    func commonInit() {
        
    }
}
