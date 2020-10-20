//
//  ListViewModel.swift
//  ExampleRxSwift
//
//  Created by Vu Xuan Cuong on 10/20/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import RxSwift
import RxCocoa
import MGArchitecture

protocol ListViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
    var array: [String] { get set }
    var dataArrayPublish: PublishSubject<[String]> { get set }
    func fetchData()
    func addData(data: String)
}

final class ListViewModel: ListViewModelProtocol {
    struct Input {
        var selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        var selected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let a = dataArrayPublish.asDriver(onErrorJustReturn: [String]())
        let selected = input.selectTrigger
            .withLatestFrom(a) { indexPath, array in
                return array[indexPath.row]
        }
        .do(onNext: {
            print($0)
        })
        .mapToVoid()
        
        return Output(selected: selected)
    }
    
    var dataArrayPublish = PublishSubject<[String]>()
    
    internal var array = [String]() {
        didSet {
            dataArrayPublish.onNext(array)
        }
    }
    
    func fetchData() {
        array = ["A", "B", "C"]
    }
    
    func addData(data: String) {
        array.append(data)
    }
}
