//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView {
    
    
    
    var curveTitles:CurveTitle!

 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        //self  UI
        self.layer.cornerRadius = 20.0
        self.backgroundColor=UIColor.white
        
        
        
        //add title
        curveTitles = CurveTitle(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.2*self.frame.height))
        self.addSubview(curveTitles)
        
        
    }
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
