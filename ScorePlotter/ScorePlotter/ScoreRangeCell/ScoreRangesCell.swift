//
//  ScoreRangesCell.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit

class ScoreRangesCell: UITableViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var arrowView: ArrowView!
    @IBOutlet weak var rangeView: UIView!
    
    func configue(with model: ScoreStat, userScore: Int) {
        percentageLabel.text = "\(model.percent)%"
        rangeLabel.text = "\(model.min)" + "-" + "\(model.max)"
        rangeView.backgroundColor = UIColor.fromRGBString(str: model.colorCode)
        
        arrowView.isHidden = true
        guard userScore >= model.min, userScore < model.max else { return }
        arrowView.isHidden = false
        arrowView.text = "\(userScore)"
        
    }
}
