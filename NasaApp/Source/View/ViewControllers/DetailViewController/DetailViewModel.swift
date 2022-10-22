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
        backButtonTapped: Driver<Void>,
        showNextImage: Driver<Void>,
        showPreviousImage: Driver<Void>
    )
}

protocol DetailViewModelOutput {
    var showImageDetail: Driver<NasaImage> { get }
}

protocol DetailVM: ViewModelType where Input: DetailViewModelInput, Output: DetailViewModelOutput {
    
}

class DetailViewModel<Router>: DetailVM {
    struct Input: DetailViewModelInput {
        let willAppear: Driver<Bool>
        let backButtonTapped: Driver<Void>
        let showNextImage: Driver<Void>
        let showPreviousImage: Driver<Void>
    }
    struct Output: DetailViewModelOutput {
        var showImageDetail: Driver<NasaImage>
    }
    private let router: Router
    private let nasaImages: Nasa
    private var selectedImageIndex: Int
    private let disposeBag = DisposeBag()
    private let selectedImageSubject = PublishSubject<NasaImage>()
    
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
                print("viewWillAppear")
                self.selectedImageSubject.onNext(self.nasaImages[self.selectedImageIndex])
            })
            .disposed(by: disposeBag)
        
        input.showNextImage
            .drive(onNext: { _ in
                self.selectedImageSubject.onNext(self.nasaImages[self.getImageIndexForEvent(event: .next)])
            })
            .disposed(by: disposeBag)
        
        input.showPreviousImage
            .drive(onNext: { _ in
                self.selectedImageSubject.onNext(self.nasaImages[self.getImageIndexForEvent(event: .previous)])
            })
            .disposed(by: disposeBag)
        
        return Output(showImageDetail: selectedImageSubject.asDriver(onErrorJustReturn: self.nasaImages[selectedImageIndex]))
    }
    
    private func getImageIndexForEvent(event: SlidingOptions) -> Int {
        switch event {
        case .next:
            if selectedImageIndex != nasaImages.count {
                selectedImageIndex += 1
            }
        case .previous:
            if selectedImageIndex != 0 {
                selectedImageIndex -= 1
            }
        }
        return selectedImageIndex
    }
}

private enum SlidingOptions {
    case next
    case previous
}
