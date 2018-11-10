//
//  MenuButton.swift
//  Papaya
//
//  Created by ran T on 10/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class MenuButton: UIButton {

   
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        self.setImage(UIImage(named: "menuB.png"), for: .normal)
        self.contentMode = .scaleAspectFit
    }
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    

}
