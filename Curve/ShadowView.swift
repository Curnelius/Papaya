//
//  ShadowView.swift
//  Papaya
//
//  Created by ran T on 03/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        self.clipsToBounds=false

        self.backgroundColor=UIColor.white
        self.layer.shadowColor=UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        self.layer.shadowOffset=CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius=8.0
        self.layer.shadowOpacity=0.75
        
        
    }
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }


}
