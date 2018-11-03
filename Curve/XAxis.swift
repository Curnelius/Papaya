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
    var axisHeight:CGFloat!

    
    
    
    
    
    init (frame : CGRect, textColor:UIColor,font:String, stripHeight:CGFloat)
    {
 
        
       labelColor=textColor
       defaultFont=font
        axisHeight=stripHeight
        
 
       super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
  
        
 
        
    }
    
    
    
 
    func updateXaxis(xAxis:[[String:CGFloat]])
    {
        
 
        
        
        //add x
        for pair in xAxis
        {
            let dateString = Array(pair.keys)[0]
            let location = Array(pair.values)[0]
            let locationOnScreen = location*frame.size.width
            
            
            let label = UILabel(frame: CGRect(x: locationOnScreen, y:frame.size.height-axisHeight, width: frame.width/12.0, height: axisHeight))
            label.text=dateString
            label.font=UIFont(name: defaultFont, size: 10)
            label.textAlignment = .center
            label.textColor=labelColor
            if (locationOnScreen>=0){self.addSubview(label)}
 
        }
    }
    
    
    //get array of y values, no strings
    func updateYaxis(yAxis:[[CGFloat:CGFloat]])
    {
        
        removeAll()
 
        //add x
        for pair in yAxis
        {
            let value = Array(pair.keys)[0]
            let location = Array(pair.values)[0]
            let locationOnScreen = location*frame.size.height
            let startY=frame.height-axisHeight-axisHeight
            
            let label = UILabel(frame: CGRect(x: 0, y:startY + locationOnScreen, width: frame.width/8.0, height: axisHeight))
            label.text=String(format: "%f", value)
            label.font=UIFont(name: defaultFont, size: 10)
            label.textAlignment = .left
            label.textColor=labelColor
            self.addSubview(label)
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

