//
//  CurveTitle.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveTitle: UIView {
    
    //title
    var title:UILabel!
    var titleDefault = ""
    var titleDefaultFont = "Lucida Grande"
    
    
    //subtitle
    var subtitle:UILabel!
    var subtitleDefault = ""
    var subtitleDefaultFont = "Lucida Grande"
    
    
    
    

    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        title=UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2.0))
        title.text=titleDefault
        title.textAlignment = .left
        title.text=titleDefault
        title.font=UIFont(name: titleDefaultFont, size: 16)
        self.addSubview(title)
        
        
        subtitle=UILabel(frame: CGRect(x: 0, y: title.frame.maxY, width: self.frame.width, height: self.frame.height/2.0))
        subtitle.text=subtitleDefault
        subtitle.textAlignment = .left
        subtitle.text=subtitleDefault
        subtitle.font=UIFont(name: subtitleDefaultFont, size: 12)
        self.addSubview(subtitle)
        
 
    }
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
