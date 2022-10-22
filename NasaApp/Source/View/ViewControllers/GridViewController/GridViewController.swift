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
import SDWebImage

class GridViewController<ViewModel: GridVM>: UIViewController, ViewType {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    private let imageSelected = BehaviorSubject<Int>(value: 0)
    private var nasaImages = Nasa()
    
    let viewModel: ViewModel
    let nib: String
    
    required init(viewModel: ViewModel, nib: String) {
        self.viewModel = viewModel
        self.nib = nib
        super.init(nibName: nib, bundle: Bundle.main)
        bind(viewModel: self.viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(output: ViewModel.Output) {
        output.loadImages
            .drive(onNext: { images in
                self.nasaImages = images
                if images.count > 0 {
                    self.bindDataToCollectionView()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func input() -> ViewModel.Input {
        ViewModel.Input(
            didLoad: rx.viewDidLoad.asDriver(),
            tappedOnCell: imageSelected.asDriver(onErrorJustReturn: 0)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = R.string.localizable.gridViewTitle()
        
        initCollectionView()
        setCollectionViewDelegate()
        bindDataToCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: R.nib.gridCollectionCell.name, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: R.reuseIdentifier.gridCell.identifier)
        setFlowLayoutForCollectionView()
    }
    private func setFlowLayoutForCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let sideLenght = Constants.gridCellWidth/3
        flowLayout.itemSize = CGSize(width: sideLenght, height: sideLenght)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Constants.collectionCellMinInterimSpacing
        flowLayout.minimumLineSpacing = Constants.collectoinCellMinLineSpacing
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    private func bindDataToCollectionView() {
        let pageTypeData = Observable<Nasa>.of(nasaImages)
        collectionView.dataSource = nil
        pageTypeData.bind(to:collectionView.rx.items(cellIdentifier: R.reuseIdentifier.gridCell.identifier, cellType: GridCollectionCell.self)) { indexPath, nasaImage, cell in
            cell.configureForImage(nasaImage: nasaImage)
        }
        .disposed(by: disposeBag)
    }
    
    private func setCollectionViewDelegate() {
        collectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.imageSelected.onNext(indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}

private enum Constants {
    static let gridCellWidth: CGFloat = UIScreen.main.bounds.width - CGFloat(64)
    static let collectionCellMinInterimSpacing: CGFloat = 8.0
    static let collectoinCellMinLineSpacing: CGFloat = 16.0
}
