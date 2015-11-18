//
//  UIColor+Extension.swift
//  Tab+scrow+coll
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

let arcRandom: CGFloat = CGFloat(arc4random_uniform(256))
extension UIColor {


    class func randomColor()->UIColor {
    
//    return UIColor.init(red: arcRandom / 255.0 , green: arcRandom / 255.0 , blue: arcRandom / 255.0 , alpha: 1)
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0 , green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
    
    }

}
