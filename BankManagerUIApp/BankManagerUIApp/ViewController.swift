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
    
    // MARK: - ScrollView
    
    lazy var onCallScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(onCallStackView)
        return scrollView
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
    
    lazy var clientStateLabelStackView: UIStackView = {
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
        stackView.addArrangedSubview(clientStateLabelStackView)
        stackView.addArrangedSubview(allClientStackView)
        return stackView
    }()
    
    lazy var allClientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(onCallScrollView)
        stackView.addArrangedSubview(onTaskStackView)
        return stackView
    }()
    
    lazy var onCallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var onTaskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillEqually
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
            headerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            onCallScrollView.topAnchor.constraint(equalTo: allClientStackView.topAnchor),
            onCallScrollView.leadingAnchor.constraint(equalTo: allClientStackView.leadingAnchor),
//            onCallScrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            onCallScrollView.bottomAnchor.constraint(equalTo: allClientStackView.bottomAnchor),
            
            onCallStackView.widthAnchor.constraint(equalTo: onCallScrollView.frameLayoutGuide.widthAnchor),
            onCallStackView.leadingAnchor.constraint(equalTo: onCallScrollView.leadingAnchor),
            onCallStackView.topAnchor.constraint(equalTo: onCallScrollView.topAnchor),
            onCallStackView.bottomAnchor.constraint(equalTo: onCallScrollView.bottomAnchor)
        ])
        
        for  _ in 1...100 {
            let label = UILabel()
            label.text = "aaaaaaa"
            onCallStackView.addArrangedSubview(label)
        }
        
        for  _ in 1...10 {
            let label = UILabel()
            label.text = "aaaaaaa"
            onTaskStackView.addArrangedSubview(label)
        }
    }
}
