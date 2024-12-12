//
//  TipsView.swift
//  Nearby
//
//  Created by Wagner Lemos Ferreira da Luz on 11/12/24.
//

import Foundation
import UIKit

public class TipsView: UIView {
    
    private let iconImageView: UIImageView = UIElementFactory.createImageView()
    private let titleLabel: UILabel = UIElementFactory.createLabel()
    private let descriptionLabel: UILabel = UIElementFactory.createDescription()
    
    init(icon: UIImage, title: String, description: String) {
        super.init(frame: .zero)
        setupComponent(icon: icon, title: title, description: description)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent(icon: UIImage, title: String, description: String) {
        iconImageView.image = icon
        titleLabel.text =  title
        titleLabel.font = Typography.titleSM
        descriptionLabel.text = description
        descriptionLabel.font = Typography.textSM
    }
    
    private func setupUI() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
