//
//  ViewModel.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 18/10/22.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func bind(input: Input) -> Output
}



