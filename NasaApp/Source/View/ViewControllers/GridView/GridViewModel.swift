//
//  GridViewModel.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
//import XCTest

protocol GridViewModelInput {
    init(
        didLoad: Driver<Void>,
        tappedOnCell: Driver<NasaImage?>
    )
}

protocol GridViewModelOutput {
    var loadImages: Driver<[NasaImage]> { get set }
}

protocol GridVM: ViewModelType where Input: GridViewModelInput, Output: GridViewModelOutput {
    func gridFirstFunction()
}

class GridViewModel<Router: MainRoutable>: GridVM {
    struct Input: GridViewModelInput {
        var didLoad: Driver<Void>
        var tappedOnCell: Driver<NasaImage?>
    }
    struct Output: GridViewModelOutput {
        var loadImages: Driver<[NasaImage]>
    }
    
    let disposeBag = DisposeBag()
    let imagesRelay: BehaviorRelay<[NasaImage]> = BehaviorRelay<[NasaImage]>(value: [])
    private let router: Router
    private let imageService: NasaImageService
    
    init(router: Router,
         imageService: NasaImageService) {
        self.router = router 
        self.imageService = imageService
    }
    
    func bind(input: Input) -> Output {
        input.didLoad
            .drive(onNext: { _ in
                guard let path = R.file.dataJson.path() else { return }
                self.imageService.getGridImages(path: path)
            })
            .disposed(by: disposeBag)
        
        imageService.images.asDriver(onErrorJustReturn: [])
            .drive(onNext: { images in
                self.imagesRelay.accept(images)
            })
            .disposed(by: disposeBag)
        
        input.tappedOnCell
            .compactMap({$0})
            .drive(onNext: { nasaImage in
//                guard let nasaImage = nasaImage else { return }
                print("User tapped on Index: \(nasaImage.title)")
            })
            .disposed(by: disposeBag)
        
        return Output(loadImages: imagesRelay.asDriver())
    }
    
    func gridFirstFunction() {
        
    }
}
