//
//  ButtonActionDelegate.swift
//  BankManagerUIApp
//
//  Created by BOMBSGIE on 2023/11/16.
//

import UIKit

protocol ButtonActionDelegate: AnyObject {
    func startTask(_ stackView: UIStackView)
    func reset()
}
