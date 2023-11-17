//
//  BankManagable.swift
//  BankManagerConsoleApp
//
//  Created by BOMBSGIE on 2023/11/07.
//

import Foundation
import UIKit

protocol BankManagable {
    var delegate: BankUIDelgate? { get set }
    
    func startWork()
    func recept(for client: Client, clientLabel: UILabel)
    func getTotalWorkTime() -> Double
    func updateTotalWorkTime()
    func resetTotalWorkTime()
}
