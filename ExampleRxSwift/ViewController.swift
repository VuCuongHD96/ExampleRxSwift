//
//  ViewController.swift
//  ExampleRxSwift
//
//  Created by Vu Xuan Cuong on 10/20/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var viewModel: ListViewModel! {
        didSet {
            viewModel.dataArrayPublish
                .bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, element, cell in
                    cell.textLabel?.text = "\(element) is row \(row)"
            }
            .disposed(by: disposeBag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListViewModel()
        viewModel.fetchData()
        setupTableView()
    }
    
    private func setupTableView() {
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                guard let cell = self.tableView.cellForRow(at: $0) else { return }
//                cell.backgroundColor = .blue
//                cell.selectionStyle = .none
//            })
//            .disposed(by: disposeBag)
        
        let input = ListViewModel.Input(selectTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        output
            .selected
            .drive()
            .disposed(by: disposeBag)
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard let addVC = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else { return }
        addVC.dataDidSave
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.addData(data: $0)
            })
            .disposed(by: disposeBag)
        navigationController?.pushViewController(addVC, animated: true)
    }
}
