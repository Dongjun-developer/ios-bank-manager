//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    
    var bankView: BankView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        bankView = BankView(frame: self.view.frame)
        self.view = bankView
    }

}


extension ViewController: ButtonActionDelegate {
    func startTask(_ stackView: UIStackView) {
        
    }
    
    func reset() {
        
    }
}
