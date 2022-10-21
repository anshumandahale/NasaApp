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
        let tappedOnCell: Driver<NasaImage?>
        
        let mockDidLoadSubject = PublishSubject<Void>()
        let mockCellTappedSubject = PublishSubject<NasaImage?>()
        
        init() {
            didLoad = mockDidLoadSubject.asDriver(onErrorJustReturn: ())
            tappedOnCell = mockCellTappedSubject.asDriver(onErrorJustReturn: nil)
        }
        
        init(didLoad: Driver<Void>,
             tappedOnCell: Driver<NasaImage?>
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
        
        mockInput.mockCellTappedSubject.onNext(getMockNasaImage())
        XCTAssertEqual(mockRouter.calledRoute, .detailView)
    }
    func getMockNasaImage() -> NasaImage {
        NasaImage(copyright: "Copyright",
                  date: "2022-10-21",
                  explanation: "Explaination",
                  hdurl: "HDURL",
                  mediaType: .image,
                  serviceVersion: "v1",
                  title: "Title",
                  url: "URL")
    }
}
