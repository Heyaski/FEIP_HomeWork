//
//  SizeEntityView.swift
//  market
//
//  Created by Степан on 19.03.2025.
//

import UIKit
import SnapKit

protocol SizeEntityViewDelegate: AnyObject {
    
    func didSelectSize(with size: String)
    
}

class SizeEntityView: UIView {
    
    weak var delegate: SizeEntityViewDelegate?
    
    private var size: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        return view
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [descriptionLabel])
        stackview.axis = .horizontal
        stackview.alignment = .center
        return stackview
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)

        label.textColor = UIColor(named: "Dark")
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "Dark")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(textStackView)
        textStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
    }
    
    func bind(size: String, isSelected: Bool) {
        self.size = size
        descriptionLabel.text = size
        containerView.backgroundColor = isSelected ? UIColor(named: "Brown") : UIColor(named: "LightGray")
        descriptionLabel.textColor = isSelected ? .white : .black
    }
    
    // MARK: - Actions
    
    @objc private func didTap() {
        guard let size else { return }
        delegate?.didSelectSize(with: size)
    }
}
