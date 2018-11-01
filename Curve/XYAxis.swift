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

class XYAxis: UIView {
    
    
    
    var labelColor:UIColor = UIColor.gray
    var resolution:Int!
    var maxXAxisValues:Int!
    let datesFilter = DatesFilter ()
    
    
    
    
    
    init (frame : CGRect, textColor:UIColor, resolutionMin:Int, maxValuesForXAxis:Int)
    {

       labelColor=textColor
       resolution=resolutionMin
       maxXAxisValues=maxValuesForXAxis
       super.init(frame : frame)
        
        
 
        
    }
    
    
    
 
    
    func getTimeAxis()->[Date]
    {
        
      //  return datesFilter.getDatesAsStrings(forDates: getListOfDates(), andResolution: resolution, maxXAxisValues: maxXAxisValues)
       let filter  = DatesFilter()
       return filter.getListOfRoundedDates(endDate: Date(), resolution: resolution, maximumValues: maxXAxisValues)
    
    }
    
    
   
    
    
   






    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
        



}

