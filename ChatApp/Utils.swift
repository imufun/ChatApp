//
//  Utils.swift
//  ChatApp
//
//  Created by sinbad on 6/8/1439 AH.
//  Copyright © 1439 AH sinbad. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green : CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

//extension UIColor {
//    
//    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
//        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
//    }
//    
//}
