//
//  ViewController.swift
//  ExampleRxSwift
//
//  Created by KIMOCHI on 10/24/20.
//  Copyright © 2020 Sun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, BindableType {
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
        print("chạy")
    }
}
