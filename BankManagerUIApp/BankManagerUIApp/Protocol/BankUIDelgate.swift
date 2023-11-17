//
//  BankUIDelgate.swift
//  BankManagerUIApp
//
//  Created by BOMBSGIE on 2023/11/17.
//

import UIKit

protocol BankUIDelgate: UIViewController {
    func startTask(_ label: UILabel)
    func finishTask(_ label: UILabel)
    func changeTaskState(_ label: UILabel)
    func makeClientLabel(number: Int) -> UILabel
}
