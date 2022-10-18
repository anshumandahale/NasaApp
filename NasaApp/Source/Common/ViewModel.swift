//
//  ViewModel.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 18/10/22.
//

import Foundation

public protocol ViewModelType {
    /// Input for the VM
    associatedtype Input
    /// Output from the VM
    associatedtype Output
    
    /// Connects Input supplied by View to Output supplied by VM
    /// - Returns: Output for View
    func bind(input: Input) -> Output
}


/// This protocol describes the contract between View and VM
public protocol ViewType {
    associatedtype ViewModel: ViewModelType
    
    init(viewModel: ViewModel, nib: String)
    
    /// Connect VM's output to the View
    func bind(output: ViewModel.Output)
    
    /// Connect VM to the View
    func bind(viewModel: ViewModel)
    
    ///  Generate Input for the VM
    /// - Returns: VM's Input object
    func input() -> ViewModel.Input
}

public extension ViewType {
    func bind(viewModel: ViewModel) {
        bind(output: viewModel.bind(input: input()))
    }
}
