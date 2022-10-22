//
//  DetailViewModel.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 21/10/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol DetailViewModelInput {
    init(
        willAppear: Driver<Bool>,
        backButtonTapped: Driver<Void>
    )
}

protocol DetailViewModelOutput {
    var images: Driver<Nasa> { get }
    var selectedIndex: Driver<Int> { get }
}

protocol DetailVM: ViewModelType where Input: DetailViewModelInput, Output: DetailViewModelOutput {
    
}

class DetailViewModel<Router: MainRoutable>: DetailVM {
    struct Input: DetailViewModelInput {
        let willAppear: Driver<Bool>
        let backButtonTapped: Driver<Void>
    }
    struct Output: DetailViewModelOutput {
        var images: Driver<Nasa>
        var selectedIndex: Driver<Int>
    }
    private let router: Router
    private let nasaImages: Nasa
    private var selectedImageIndex: Int
    private let disposeBag = DisposeBag()
    private let imagesSubject = PublishSubject<Nasa>()
    private let selectedImageIndexSubject = PublishSubject<Int>()
    
    init(router: Router,
         images: Nasa,
         selectedImageIndex: Int) {
        self.router = router
        self.nasaImages = images
        self.selectedImageIndex = selectedImageIndex
    }
    
    func bind(input: Input) -> Output {
        input.willAppear
            .drive(onNext: { _ in
                self.imagesSubject.onNext(self.nasaImages)
                self.selectedImageIndexSubject.onNext(self.selectedImageIndex)
            })
            .disposed(by: disposeBag)
        
        input.backButtonTapped
            .drive(onNext: { _ in
                self.router.popToGridVC()
            })
            .disposed(by: disposeBag)
        
        return Output(
            images: imagesSubject.asDriver(onErrorJustReturn: self.nasaImages),
            selectedIndex: selectedImageIndexSubject.asDriver(onErrorJustReturn: 0)
        )
    }
}
