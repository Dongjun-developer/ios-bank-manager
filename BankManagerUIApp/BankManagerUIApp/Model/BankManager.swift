//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import UIKit

final class BankManager: BankManagable {
    private var clientQueue = Queue<Client>()
    private var totalWorkTime = 0.0
    private let loanSemaphore: DispatchSemaphore
    private let depositSemaphore: DispatchSemaphore
    weak var delegate: BankUIDelgate?
    
    init(loanClerkCount: Int, depositClerkCount: Int) {
        self.loanSemaphore = DispatchSemaphore(value: loanClerkCount)
        self.depositSemaphore = DispatchSemaphore(value: depositClerkCount)
    }
    
    func recept(for client: Client) {
        self.clientQueue.enqueue(client)
    }
    
    func startWork() {
        let group = DispatchGroup()
        
        while self.clientQueue.isEmpty == false {
            guard let client = self.clientQueue.dequeue() else { return }
            switch client.taskType {
            case .loan:
                self.callClient(semaphore: loanSemaphore, group: group, client: client)
            case .deposit:
                self.callClient(semaphore: depositSemaphore, group: group, client: client)
            }
        }
        
        group.wait()
    }
    
    func getTotalWorkTime() -> Double {
        return self.totalWorkTime
    }
    
    func updateTotalWorkTime() {
        self.totalWorkTime += 1
    }
    
    func resetTotalWorkTime() {
        self.totalWorkTime = 0
    }
    
    private func callClient(semaphore: DispatchSemaphore, group: DispatchGroup, client: Client) {
      

        semaphore.wait()
        DispatchQueue.global().async(group: group) {
//        guard let client = self.clientQueue.dequeue() else { return }
            self.changeState(client: client, group: group)
            semaphore.signal()
        }
        group.wait()
    }
    
    private func changeState(client: Client, group: DispatchGroup) {
        DispatchQueue.main.async {
//            print("\(client)")
            guard let label = self.delegate?.makeClientLabel(number: client.id) else { return }
            self.delegate?.startTask(label)
            self.working(for: client.taskType.requiredTime, clientLabel: label, group: group)
        }
    }
    
    private func task(for client: Client, clientLabel: UILabel, group: DispatchGroup) {
        print(WorkState.start(client: client))
        self.working(for: client.taskType.requiredTime, clientLabel: clientLabel, group: group)
        print(WorkState.end(client: client))
    }
    
    private func working(for time: Double, clientLabel: UILabel, group: DispatchGroup) {
        self.delegate?.changeTaskState(clientLabel)
        DispatchQueue.global().async(group: group) {
            Thread.sleep(forTimeInterval: time)
        }
        self.delegate?.finishTask(clientLabel)
    }
}

extension BankManager {
    private enum WorkState: CustomStringConvertible  {
        case start(client: Client)
        case end(client: Client)
        
        var description: String {
            switch self {
            case .start(let client):
                return "\(client) \(client.taskType)업무 시작"
            case .end(let client):
                return "\(client) \(client.taskType)업무 완료"
            }
        }
    }
}
