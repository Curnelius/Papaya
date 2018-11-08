//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView {
    
    
    
 
      var container:CurveContainer!
    
      var cornerRadius = 24.0
    
    
    
    //observe vars changes all the time
     var title = "" {   didSet  {container.curveTitles.title.text=title}  }
     var subtitle = "" {   didSet  {container.curveTitles.subtitle.text=subtitle}  }
     var font = "" {   didSet  {
            container.curveTitles.title.font=UIFont(name: font, size: 24)
            container.curveTitles.subtitle.font=UIFont(name: font, size: 12)
            }}

        
            
 
  
    
 
    
 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        
        //THIS VIEW HOLDS THE CONTAINER THAT HOLDS THE OTHER VIEWS
        //THIS VIEW HAS THE SHADOW AND TAKE CARE OF LOGICS
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.backgroundColor=UIColor.white
        self.clipsToBounds=false
        self.backgroundColor=UIColor.white
        self.layer.shadowColor=UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0).cgColor
        self.layer.shadowOffset=CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius=5.0
        self.layer.shadowOpacity=1.0
        
        
        //add container with all views
        container = CurveContainer(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(container)
        
       
        
 
     }
    
    
      convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    
    
    
    func addNewCurve(name:String, data:[[String:Any]], fillColor:UIColor, lineColor:UIColor, animation:String)
    {
        container.addNewCurve(name: name, data: data, fillColor: fillColor, lineColor: lineColor, animation: animation)
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
