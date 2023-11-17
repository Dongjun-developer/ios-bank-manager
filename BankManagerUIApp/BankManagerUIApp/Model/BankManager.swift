//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import UIKit

final class BankManager: BankManagable {
    private var clientQueue = Queue<Client>()
    private var clientDictionary = Dictionary<Client, UILabel>()
    private var totalWorkTime = 0.0
    private var dq = DispatchQueue(label: "dq", qos: .utility, attributes: .concurrent)
    private let loanSemaphore: DispatchSemaphore
    private let depositSemaphore: DispatchSemaphore
    weak var delegate: BankUIDelgate?
    
    init(loanClerkCount: Int, depositClerkCount: Int) {
        self.loanSemaphore = DispatchSemaphore(value: loanClerkCount)
        self.depositSemaphore = DispatchSemaphore(value: depositClerkCount)
    }
    
    func recept(for client: Client, clientLabel: UILabel) {
        self.clientQueue.enqueue(client)
        self.clientDictionary[client] = clientLabel
    }
    
    
    func startWork() {
        let group = DispatchGroup()
        
        while self.clientQueue.isEmpty == false {
            guard let client = self.clientQueue.dequeue() else { return }
            dq.async {
                switch client.taskType {
                case .loan:
                    self.callClient(semaphore: self.loanSemaphore, group: group, client: client)
                case .deposit:
                    self.callClient(semaphore: self.depositSemaphore, group: group, client: client)
                }
            }
        }
        
        //group.wait()
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
        let clientLabel = self.clientDictionary[client]!
        DispatchQueue.main.async {
            self.delegate?.startTask(clientLabel)
        }
        semaphore.wait()
        DispatchQueue.main.async {
            self.delegate?.changeTaskState(clientLabel)
        }
        print("hi")
        
        //            Thread.sleep(forTimeInterval: client.taskType.requiredTime)
        DispatchQueue.main.asyncAfter(deadline: .now() + client.taskType.requiredTime) {
            self.delegate?.finishTask(clientLabel)
            semaphore.signal()
        }
    }
    
    private func working(for time: Double, clientLabel: UILabel, group: DispatchGroup) {
        
    }
    
    private func task(for client: Client, clientLabel: UILabel, group: DispatchGroup) {
        print(WorkState.start(client: client))
        self.working(for: client.taskType.requiredTime, clientLabel: clientLabel, group: group)
        print(WorkState.end(client: client))
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
