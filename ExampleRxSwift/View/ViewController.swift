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

final class ViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var statusLabel: UILabel!
    
    private var viewModel = LoginViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = LoginViewModel.Input(id: idTextField.rx.text.orEmpty.asObservable(),
                                         pass: passTextField.rx.text.orEmpty.asObservable(),
                                         validate: registerButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        output.infor
            .drive(statusLabel.rx.text)
            .disposed(by: bag)
        
        output.buttonStatus
            .drive(registerButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.buttonStatus
            .map {
                $0 ? 1 : 0.5
        }
        .drive(registerButton.rx.alpha)
        .disposed(by: bag)
    }
}

