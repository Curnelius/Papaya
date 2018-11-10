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


protocol XAxisProtocol : class {
    
    func XAxisDelegate(offset:CGFloat )
    
}




class XAxis: UIView,UIScrollViewDelegate {
    
    
    
    var labelColor:UIColor = UIColor.gray
    let datesFilter = DatesFilter ()
    var defaultFont = "Avenir-Light"
    var scroller:UIScrollView!
    var delegate:XAxisProtocol! = nil

    
    
    
    
    init (frame : CGRect, textColor:UIColor,font:String,scrollerContentWidth:CGFloat)
    {
 
        
       labelColor=textColor
       defaultFont=font
 
 
        super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
        self.isUserInteractionEnabled=true
        
        
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        scroller.alwaysBounceHorizontal = true
        scroller.contentSize=CGSize(width: scrollerContentWidth, height: frame.height)
        scroller.backgroundColor=UIColor.clear
        scroller.delegate=self
        scroller.bounces=false
        scroller.showsHorizontalScrollIndicator=false
        self.addSubview(scroller)
        
 
 
 
 
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 
        self.delegate?.XAxisDelegate(offset: scrollView.contentOffset.x)
    }
    
    
 
    func updateXaxis(xAxis:[[String:CGFloat]])
    {
       removeAll()
        
        
        //add x
        for pair in xAxis
        {
   
            
            let dateString = Array(pair.keys)[0]
            let location = Array(pair.values)[0]
            let locationOnScreen = location*scroller.contentSize.width
            let labelWidth=frame.width/10.0
            let label = UILabel(frame: CGRect(x: locationOnScreen-labelWidth/2.0, y:0, width: labelWidth, height: frame.size.height))
            label.text=dateString
            label.font=UIFont(name: defaultFont, size: 10)
            label.textAlignment = .center
            label.textColor=labelColor
            label.layoutSubviews()
            if (locationOnScreen>=0){scroller.addSubview(label)}
            let line = UIView(frame: CGRect(x: label.frame.midX-1.0, y: 0, width: 1.0, height: 4.0))
            line.backgroundColor=label.textColor
            scroller.addSubview(line)
 
        }
        
        scroller.setContentOffset(CGPoint(x: scroller.contentSize.width-scroller.frame.width, y: 0), animated: true)
 
 
    }
    
    
   
   
    
    
    func removeAll()
    {
        for view in scroller.subviews {view.removeFromSuperview()}
    }






    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
        



}

