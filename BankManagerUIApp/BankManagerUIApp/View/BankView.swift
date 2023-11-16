//
//  BankView.swift
//  BankManagerUIApp
//
//  Created by BOMBSGIE on 2023/11/16.
//

import UIKit

final class BankView: UIView {
    
    weak var delegate: ButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    // MARK: - Button
    
    private lazy var addClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapAddClientButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(tapResetButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Label
    
    private lazy var taskTimerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "업무 시간 - 00:00:000"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var onCallLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var onTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    // MARK: - ScrollView
    
    private lazy var onCallScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(self.onCallStackView)
        return scrollView
    }()
    
    // MARK: - StackView

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(self.addClientButton)
        stackView.addArrangedSubview(self.resetButton)
        return stackView
    }()
    
    private lazy var clientStateLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(self.onCallLabel)
        stackView.addArrangedSubview(self.onTaskLabel)
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(self.buttonStackView)
        stackView.addArrangedSubview(self.taskTimerLabel)
        stackView.addArrangedSubview(self.clientStateLabelStackView)
        stackView.addArrangedSubview(self.allClientStackView)
        return stackView
    }()
    
    private lazy var allClientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(self.onCallScrollView)
        stackView.addArrangedSubview(self.onTaskStackView)
        return stackView
    }()
    
    private lazy var onCallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var onTaskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(headerStackView)
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            onCallScrollView.topAnchor.constraint(equalTo: self.allClientStackView.topAnchor),
            onCallScrollView.leadingAnchor.constraint(equalTo: self.allClientStackView.leadingAnchor),
            onCallScrollView.bottomAnchor.constraint(equalTo: self.allClientStackView.bottomAnchor),
            
            onCallStackView.widthAnchor.constraint(equalTo: self.onCallScrollView.frameLayoutGuide.widthAnchor),
            onCallStackView.leadingAnchor.constraint(equalTo: self.onCallScrollView.leadingAnchor),
            onCallStackView.topAnchor.constraint(equalTo: self.onCallScrollView.topAnchor),
            onCallStackView.bottomAnchor.constraint(equalTo: self.onCallScrollView.bottomAnchor)
        ])
    }
}


extension BankView {
    
    @objc private func tapAddClientButton() {
        delegate?.startTask(onCallStackView)
    }
    
    @objc private func tapResetButton() {
        delegate?.reset()
    }
}
