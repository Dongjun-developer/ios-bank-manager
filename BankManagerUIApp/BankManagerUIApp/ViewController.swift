//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    
    private var bankView: BankView!
    private var timer: Timer?
    private var bankManager: BankManagable = BankManager(loanClerkCount: 1, depositClerkCount: 2)
    private let timeFormatter = TimeFormatter()
//    private lazy var bank = Bank(bankManager: bankManager)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bankView.delegate = self
        self.bankManager.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        self.bankView = BankView(frame: self.view.frame)
        self.view = bankView
    }
    
    private func startTimer() {
        guard let _ = timer else {
            self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer!, forMode: .common)
            return
        }
    }
    
    @objc private func timerCounter() {
        let timeString = self.timeFormatter.make(self.bankManager)
        self.bankView.updateTimerLabel(timeString)
    }
    
    private func timerReset() {
        self.bankManager.resetTotalWorkTime()
        self.timer?.invalidate()
        self.timer = nil
        self.bankView.updateTimerLabel("00:00:000")
    }
    
    func makeClientLabel(number: Int) -> UILabel {
        let client = receptionClient(id: number)
        let label = UILabel()
        label.text = "\(client)"
        label.textColor = client.taskType == .deposit ? .black : .systemPurple
        return label
    }
    
    private func receptionClient(id: Int) -> Client {
        let taskType = TaskType.allCases.randomElement()!
        return Client(id: id, taskType: taskType)
    }
}


extension ViewController: ButtonActionDelegate {
    func startTask(_ stackView: UIStackView) {
        self.startTimer()
        for i in 1...10 {
            let client = receptionClient(id: i)
            self.bankManager.recept(for: client)
        }
        self.bankManager.startWork()
    }
    
    func reset() {
        self.timerReset()
    }
}

extension ViewController: BankUIDelgate {
    func finishTask(_ label: UILabel) {
        bankView.onTaskStackView.removeArrangedSubview(label)
        label.removeFromSuperview()
    }
    
    func changeTaskState(_ label: UILabel) {
        bankView.onCallStackView.removeArrangedSubview(label)
        bankView.onTaskStackView.addArrangedSubview(label)
    }
    
    func startTask(_ label: UILabel) {
        bankView.onCallStackView.addArrangedSubview(label)
    }
}

// MARK: - TimeFormatter 분리
struct TimeFormatter {
    
    func make(_ bankManager: BankManagable) -> String {
        bankManager.updateTotalWorkTime()
        let time = Int(bankManager.getTotalWorkTime())
        let text = makeTimeString(with: time)
        return text
    }
    
    private func makeTimeString(with milliSeconds: Int) -> String {
        let timerTuple = self.computeMilliSecond(with: milliSeconds)
        let timeString = "\(String(format: "%02d", timerTuple.0)):\(String(format: "%02d", timerTuple.1)):\(String(format: "%03d", timerTuple.2))"
        return timeString
    }
    
    private func computeMilliSecond(with milliseconds: Int) -> (Int, Int, Int) {
        return (((milliseconds / 1000) / 60), (milliseconds / 1000), milliseconds % 1000)
    }
    
}
