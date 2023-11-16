//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Button
    
    lazy var addClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    // MARK: - Label
    
    lazy var taskTimerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "업무 시간 - 00:00:000"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    lazy var onCallLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    lazy var onTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    // MARK: - StackView
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(self.addClientButton)
        stackView.addArrangedSubview(self.resetButton)
        return stackView
    }()
    
    lazy var clientStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(onCallLabel)
        stackView.addArrangedSubview(onTaskLabel)
        return stackView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(buttonStackView)
        stackView.addArrangedSubview(taskTimerLabel)
        stackView.addArrangedSubview(clientStateStackView)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

}


extension ViewController {
    private func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(headerStackView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
