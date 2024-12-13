//
//  WelcomeView.swift
//  Nearby
//
//  Created by Wagner Lemos Ferreira da Luz on 11/12/24.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    
    var didTapButton: (() -> Void?)?
    
    private let logoView: UIImageView = UIElementFactory.createImageView()
    private let welcomeLabel: UILabel = UIElementFactory.createLabel()
    private let subtextForTips: UILabel = UIElementFactory.createLabel()
    private let descriptionLabel: UILabel = UIElementFactory.createDescription()
    private let button: UIButton = {
        let button = UIElementFactory.createDefaultButton(title: "Começar")
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        logoView.image = UIImage(named: "logoIcon")
        welcomeLabel.text = "Boas vindas ao Nearby!"
        welcomeLabel.font = Typography.titleXL
        subtextForTips.text = "Veja como funciona:"
        subtextForTips.font = Typography.textMD
        descriptionLabel.text =  "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos"
        descriptionLabel.font = Typography.titleMD
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupUI() {
        setupTips()
        addSubview(logoView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(subtextForTips)
        addSubview(tipsStackView)
        addSubview(button)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            logoView.widthAnchor.constraint(equalToConstant: 48),
            logoView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            subtextForTips.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            subtextForTips.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            tipsStackView.topAnchor.constraint(equalTo: subtextForTips.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
    
    private func setupTips() {
        let tip1 = TipsView(
                    icon: UIImage(named: "mapIcon") ?? UIImage(),
                    title:"Encontre estabelecimentos",
                    description: "Veja locais perto de você que são parceiros Nearby")
        
        let tip2 = TipsView(
                    icon: UIImage(named: "qrcode") ?? UIImage(),
                    title:"Ative o cupom com QR Code",
                    description: "Escaneie o código no estabelecimento para usar o benefício")
        
        let tip3 = TipsView(
                    icon: UIImage(named: "ticket") ?? UIImage(),
                    title:"Garanta vantagens perto de você",
                    description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
    
    @objc
    private func didTap() {
        didTapButton?()
    }
}
