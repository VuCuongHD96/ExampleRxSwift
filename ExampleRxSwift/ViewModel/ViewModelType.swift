//
//  ViewModelType.swift
//  ExampleRxSwift
//
//  Created by KIMOCHI on 10/25/20.
//  Copyright © 2020 Sun. All rights reserved.
//

import Foundation

protocol ViewModelType: class {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
