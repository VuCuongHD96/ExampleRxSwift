//
//  BindableType.swift
//  ExampleRxSwift
//
//  Created by KIMOCHI on 10/25/20.
//  Copyright © 2020 Sun. All rights reserved.
//

import UIKit
import RxSwift

public protocol BindableType: class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
