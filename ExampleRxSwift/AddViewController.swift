//
//  AddViewController.swift
//  ExampleRxSwift
//
//  Created by Vu Xuan Cuong on 10/20/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import UIKit
import RxSwift

final class AddViewController: UIViewController {
    
    @IBOutlet weak var addTextField: UITextField!
    
    private var note = PublishSubject<String>()
    var dataDidSave: Observable<String> {
        return note.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let text = addTextField.text else { return }
        note.onNext(text)
        navigationController?.popViewController(animated: true)
    }
}
