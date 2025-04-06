//
//  PrimaryButton.swift
//  market
//
//  Created by Степан on 19.03.2025.
//

import UIKit

class PrimaryButton: UIButton {
    
    init(title: String, backgroundColor: UIColor = UIColor.brown, cornerRadius: CGFloat = 12) {
        super.init(frame: .zero)
        setupButton(title: title, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupButton(title: String, backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
    }
    
}
