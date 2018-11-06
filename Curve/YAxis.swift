//
//  YAxis.swift
//  Papaya
//
//  Created by ran T on 03/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class YAxis: UIView {

    
    var labelColor:UIColor = UIColor.gray
    let datesFilter = DatesFilter ()
    var defaultFont = "Avenir-Light"
 
    
    
    
    init (frame : CGRect, textColor:UIColor,font:String )
    {
        
        
        labelColor=textColor
        defaultFont=font
 
        
        
        
        super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
        
        
        
        
    }
    
    
    
    
    //get array of y values, no strings
    func updateYaxis(yAxis:[[CGFloat:CGFloat]])
    {
        
        removeAll()
        
        superview?.bringSubviewToFront(self)
        
        
        //add x
        for pair in yAxis
        {
            let value = Array(pair.keys)[0]
            let location = Array(pair.values)[0]
            let locationOnScreen = frame.size.height - (location*frame.size.height)
            
            let label = UILabel(frame: CGRect(x: 0.1*frame.width, y: locationOnScreen, width: frame.width, height:  frame.width))
            if ( value < 1) { label.text=String(format: "%.3f", value)}
            else{ label.text=String(format: "%.1f", value)}
            label.center.y=locationOnScreen
            label.font=UIFont(name: defaultFont, size: 10)
            label.textAlignment = .left
            label.textColor=labelColor
            label.backgroundColor=UIColor.clear
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
