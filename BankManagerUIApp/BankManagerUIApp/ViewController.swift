//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    
    private var bankView: BankView!
    private var timer: Timer?
    private var timeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        bankView = BankView(frame: self.view.frame)
        self.view = bankView
    }
    
    private func startTimer() {
        guard let _ = timer else {
            self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            return
        }
    }
    
    @objc private func timerCounter() {
        timeCount += 1
        let timeTuple = milliSecondToMinutesSecondMillisecond(with: timeCount)
        let timeString = makeTimeString(minutes: timeTuple.0, seconds: timeTuple.1, milliseconds: timeTuple.2)
        self.bankView.updateTimerLabel(timeString)
    }
    
    private func milliSecondToMinutesSecondMillisecond(with milliseconds: Int) -> (Int, Int, Int) {
        return (((milliseconds / 1000) / 60), (milliseconds / 1000), milliseconds % 1000)
    }
    
    private func makeTimeString(minutes: Int, seconds: Int, milliseconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        timeString += ":"
        timeString += String(format: "%03d", milliseconds)
        return timeString
    }
    
    private func timerReset() {
        self.timeCount = 0
        self.timer?.invalidate()
        self.bankView.updateTimerLabel("00:00:000")
    }
}


extension ViewController: ButtonActionDelegate {
    func startTask(_ stackView: UIStackView) {
        self.startTimer()
    }
    
    func reset() {
        self.timerReset()
    }
}
