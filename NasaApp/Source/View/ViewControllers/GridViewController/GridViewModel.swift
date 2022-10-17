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
    var didLoad: Driver<Void> { get set }
    var tappedOnCell: Driver<Int> { get set }
}

protocol GridViewModelOutput {
    var loadImages: Driver<[NasaImage]> { get set }
}

protocol GridVM: ViewModel where Input: GridViewModelInput, Output: GridViewModelOutput {
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
    
    init(router: MainCoordinator) {
        self.coordinator = router as! Coordinator
    }
    
    func bind(input: Input) -> Output {
        input.didLoad
            .drive(onNext: { _ in
                print("DidLoad")
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
