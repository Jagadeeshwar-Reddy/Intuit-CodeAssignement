//
//  UIColor+extension.swift
//  ScorePlotter
//
//  Created by Lucky on 16/01/20.
//  Copyright © 2020 Jagadeesh. All rights reserved.
//

import UIKit

public extension UIColor {
    class func fromRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}

public extension UIColor {
    static func fromRGBString(str: String) -> UIColor {
        let values = str.components(separatedBy: ",").compactMap { Double($0) }
        guard values.count == 3 else { return UIColor.white }
        
        return UIColor(red: CGFloat(values[0]/255.0), green: CGFloat(values[1]/255.0), blue: CGFloat(values[2]/255.0), alpha: 1)
    }
}
