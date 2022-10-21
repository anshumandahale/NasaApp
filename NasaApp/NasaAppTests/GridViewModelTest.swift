//
//  GridViewModelTest.swift
//  NasaAppTests
//
//  Created by Anshuman Dahale on 21/10/22.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import NasaApp

class GridViewModelTest: XCTestCase {
    
    var mockRouter: MockMainRouter!
    var mockImageService: NasaImageService!
    
    var viewModel: GridViewModel<MockMainRouter>!
    var mockInput: MockInput!
    var output: GridViewModel<MockMainRouter>.Output!
    
    var disposeBag: DisposeBag!
    
    struct MockInput: GridViewModelInput {
        let didLoad: Driver<Void>
        let tappedOnCell: Driver<Int>
        
        let mockDidLoadSubject = PublishSubject<Void>()
        let mockCellTappedSubject = PublishSubject<Int>()
        
        init() {
            didLoad = mockDidLoadSubject.asDriver(onErrorJustReturn: ())
            tappedOnCell = mockCellTappedSubject.asDriver(onErrorJustReturn: 0)
        }
        
        init(didLoad: Driver<Void>,
             tappedOnCell: Driver<Int>
        ) {
            self.didLoad = didLoad
            self.tappedOnCell = tappedOnCell
        }
    }
    
    override func setUp() {
        super.setUp()
        mockRouter = MockMainRouter()
        mockImageService = NasaImageService()
        viewModel = GridViewModel(router: mockRouter, imageService: mockImageService)
        mockInput = MockInput()
        output = viewModel.bind(input: convertMockInput(mockInput))
        disposeBag = DisposeBag()
    }
    
    func convertMockInput(_ mockInput: MockInput) -> GridViewModel<MockMainRouter>.Input {
        GridViewModel.Input(
            didLoad: mockInput.didLoad,
            tappedOnCell: mockInput.tappedOnCell
        )
    }
    
    func testThatOnLoadingOfGridViewServiceFetchesMoreThanOneImageSuccessfully() {
        mockInput.mockDidLoadSubject.onNext(())
        XCTAssertGreaterThan(viewModel.imagesRelay.value.count, 1)
    }
    
    func testThatAfterTappingGridImageDetailViewIsOpened() {
        XCTAssertNil(mockRouter.calledRoute)
        
        mockInput.mockCellTappedSubject.onNext(1)
        XCTAssertEqual(mockRouter.calledRoute, .detailView)
    }
}
