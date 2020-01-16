//
//  ScoreArcView.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit

@IBDesignable
class ScoreArcView: UIView {
    @IBInspectable
    public var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
            updateScore()
        }
    }
    
    private var trackPathLayer: CAShapeLayer!
    private var fillPathLayer: CAShapeLayer!
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = fillColor
        label.font = UIFont.boldSystemFont(ofSize: 45.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var analysisDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date())
        label.text = "As of \(dateString)"

        return label
    }()
    
    @IBInspectable
    var fillColor: UIColor = UIColor.fromRGB(r: 230.0, g: 180.0, b: 90.0) {
        didSet {
            layoutIfNeeded()
        }
    }

    private var scoreMaxValue: CGFloat = 1000.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard trackPathLayer == nil, fillPathLayer == nil else {
            updateArcs()
            return
        }
        addArcs()
    }
    
    private func setupUI() {
        //scoreLabel
        addSubview(scoreLabel)
        scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        //dateLabel
        addSubview(analysisDateLabel)
        analysisDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        analysisDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    private func updateScore() {
        fillPathLayer.strokeEnd = CGFloat(CGFloat(score)/scoreMaxValue)
    }
}

// Arc drawing & updates
private extension ScoreArcView {
    private func addArcs() {
        trackPathLayer = arcLayer(strokeColor: .lightGray)
        fillPathLayer = arcLayer(strokeColor: fillColor)
        layer.addSublayer(trackPathLayer)
        layer.addSublayer(fillPathLayer)
        trackPathLayer.strokeEnd = 1.0
    }

    private func updateArcs() {
        let centerBounds = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        trackPathLayer.position = centerBounds
        fillPathLayer.position = centerBounds
    }
    
    private func arcLayer(fillColor: UIColor = .clear, strokeColor: UIColor) -> CAShapeLayer {
        let radius: CGFloat = 100
        let startAngle: CGFloat = CGFloat.pi/2
        let endAngle: CGFloat = 0
        let centerBounds = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let layer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        layer.path = bezierPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = 30.0
        layer.strokeEnd = 0
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = centerBounds
        
        return layer
    }
}
