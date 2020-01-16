//
//  ArrowView.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit

@IBDesignable
class ArrowView: UIView {

    @IBInspectable
    var text: String = "" {
        didSet {
            textLabel.text = text
            layoutIfNeeded()
        }
    }
    
    private var arrowLayer: CAShapeLayer!
    private var textLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        lbl.textColor = UIColor.darkGray
        lbl.text = "--"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowLayer?.removeFromSuperlayer()
        
        // arrow path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: bounds.width, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: -18, y: bounds.height / 2))
        bezierPath.addLine(to: CGPoint(x: 0, y: bounds.height))
        bezierPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        bezierPath.close()
        
        arrowLayer = CAShapeLayer()
        arrowLayer.path = bezierPath.cgPath
        arrowLayer.fillColor = UIColor.white.cgColor
        arrowLayer.lineWidth = 0
        arrowLayer.shadowColor = UIColor.black.cgColor
        arrowLayer.shadowOpacity = 0.5
        arrowLayer.shadowPath = bezierPath.cgPath
        arrowLayer.shadowOffset = CGSize(width: 5, height: 5)
        layer.addSublayer(arrowLayer)

        bringSubviewToFront(textLabel)
    }

}
