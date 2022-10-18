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

protocol GridViewModelInput {
    init(
        didLoad: Driver<Void>,
        tappedOnCell: Driver<Int>
    )
}

protocol GridViewModelOutput {
    var loadImages: Driver<[NasaImage]> { get set }
}

protocol GridVM: ViewModelType where Input: GridViewModelInput, Output: GridViewModelOutput {
    func gridFirstFunction()
}

class GridViewModel<Coordinator: MainCoordinator>: GridVM {
    struct Input: GridViewModelInput {
        var didLoad: Driver<Void>
        var tappedOnCell: Driver<Int>
    }
    struct Output: GridViewModelOutput {
        var loadImages: Driver<[NasaImage]>
    }
    
    let disposeBag = DisposeBag()
    let imagesRelay: BehaviorRelay<[NasaImage]> = BehaviorRelay<[NasaImage]>(value: [])
    private let coordinator: Coordinator
    private let imageService: NasaImageService
    
    init(router: MainCoordinator,
         imageService: NasaImageService) {
        self.coordinator = router as! Coordinator
        self.imageService = imageService
    }
    
    func bind(input: Input) -> Output {
        input.didLoad
            .drive(onNext: { _ in
                print("DidLoad")
                print("Getting images from Service")
                guard let path = R.file.dataJson.path() else { return }
                self.imageService.getGridImages(path: path)
            })
            .disposed(by: disposeBag)
        
        input.tappedOnCell
            .drive(onNext: { index in
                print("User tapped on Index: \(index)")
            })
            .disposed(by: disposeBag)
        
        return Output(loadImages: imagesRelay.asDriver())
    }
    
    func gridFirstFunction() {
        
    }
}
