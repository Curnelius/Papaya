//
//  XYAxis.swift
//  Papaya
//
//  Created by ran T on 31/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit



// get time axis:
// by resolution (in minutes back from current date), get the open time (open->now)
// define a timeDivider for each resolution (in minutes) - each how many minutes we jump
//get a list of dates by jumping from open date and up, stop before arriving to now
//convert dates to strings (+round minutes by resolution)


// get raw list of dates in time span (resolution)
// get cleaned and rounded list of dates
// get pairs for strings and locations

class XAxis: UIView {
    
    
    
    var labelColor:UIColor = UIColor.gray
    let datesFilter = DatesFilter ()
    var defaultFont = "Avenir-Light"

    
    
    
    
    
    init (frame : CGRect, textColor:UIColor,font:String)
    {
 
        
       labelColor=textColor
       defaultFont=font
        
 
       super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
  
        
 
        
    }
    
    
    
 
    func updateXaxis(xAxis:[[String:CGFloat]])
    {
        
       removeAll()
        
        
        //add x
        for pair in xAxis
        {
            let dateString = Array(pair.keys)[0]
            let location = Array(pair.values)[0]
            let locationOnScreen = location*frame.size.width
            let labelWidth=frame.width/10.0
            
            let label = UILabel(frame: CGRect(x: locationOnScreen-labelWidth/2.0, y:0, width: labelWidth, height: frame.size.height))
            label.text=dateString
            label.font=UIFont(name: defaultFont, size: 10)
            label.textAlignment = .center
            label.textColor=labelColor
            if (locationOnScreen>=0){self.addSubview(label)}
            
            let line = UIView(frame: CGRect(x: label.frame.midX-1.0, y: 0, width: 1.0, height: 4.0))
            line.backgroundColor=label.textColor
            self.addSubview(line)
 
        }
    }
    
    
   
   
    
    
    func removeAll()
    {
        for view in self.subviews {view.removeFromSuperview()}
    }






    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
        



}

