//
//  ViewModel.swift
//  ExampleRxSwift
//
//  Created by KIMOCHI on 10/24/20.
//  Copyright © 2020 Sun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelType: class {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class LoginViewModel: LoginViewModelType {
    struct Input {
        let id: Observable<String>
        let pass: Observable<String>
        let validate: Observable<Void>
    }
    
    struct Output {
        let infor: Driver<String>
        let buttonStatus: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let infor = handle(input)
        let enable = handleEnable(input)
        return Output(infor: infor, buttonStatus: enable)
    }
    
    private func handle(_ input: Input) -> Driver<String> {
        return Observable.combineLatest(input.id, input.pass).map { id, pass in
            if id.isEmpty {
                return "Hãy nhập ID"
            }
            if pass.isEmpty {
                return "Hãy nhập pass"
            }
            else {
                return "Sẵn sàng đăng nhập"
            }
        }
        .startWith("")
        .asDriver(onErrorJustReturn: ":-(")
    }
    
    private func handleEnable(_ input: Input) -> Driver<Bool> {
        return Observable.combineLatest(input.id, input.pass).map {
            $0.count > 3 && $1.count > 3
        }
        .startWith(false)
        .asDriver(onErrorJustReturn: true)
    }
}
