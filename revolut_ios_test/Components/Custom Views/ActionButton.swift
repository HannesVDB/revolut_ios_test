//
//  ActionButton.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 24/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    var title: String? {
        didSet {
            descriptionLabel.text = title
        }
    }
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "plus_icon"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor(named: "action_blue_color")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawView()
    }
    
    private func drawView() {
        addSubview(iconView)
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // MARK: - Animation
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate {
            self.backgroundColor = UIColor.lightGray
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate {
            self.backgroundColor = UIColor.white
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate {
            self.backgroundColor = UIColor.white
        }
    }
    
    private func animate(_ block: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: block,
                       completion: nil)
    }
}
