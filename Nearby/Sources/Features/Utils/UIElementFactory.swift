//
//  UIElementFactory.swift
//  Nearby
//
//  Created by Wagner Lemos Ferreira da Luz on 11/12/24.
//

import Foundation
import UIKit

class UIElementFactory {
    
    static func createImageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }
    
    static func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleMD
        label.numberOfLines = 0
        return label
    }
    
    static func createDescription() -> UILabel {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = Typography.titleSM
        description.numberOfLines = 0
        return description
    }
    
    static func createDefaultButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor =  Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = Typography.action
        
        return button
    }
}
