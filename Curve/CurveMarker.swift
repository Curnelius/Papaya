//
//  CurveMarker.swift
//  Papaya
//
//  Created by ran T on 04/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveMarker: UIView {

    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        let marker = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        marker.layer.cornerRadius=frame.width/2.0
        marker.backgroundColor=UIColor.red
        self.addSubview(marker)
    }
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
