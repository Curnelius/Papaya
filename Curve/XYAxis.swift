//
//  XYAxis.swift
//  Papaya
//
//  Created by ran T on 31/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit




class XYAxis: UIView {
    
    
    
    var labelColor:UIColor = UIColor.gray
    var resolution:Int!
    let datesFilter = DatesFilter ()
    
    
    
    
    init (frame : CGRect, textColor:UIColor, resolutionMin:Int)
    {

       labelColor=textColor
       resolution=resolutionMin
       super.init(frame : frame)
        
        
       print( self.getTimeAxis())
 
        
    }
    
    
    
 
    
    func getTimeAxis()->[String]
    {
        
      return datesFilter.getDatesAsStrings(forDates: getListOfDates(), andResolution: resolution)
        
    }
    
    
    private func getListOfDates()->[Date]
    {
        
        
        var finalDates = [Date]()
        let openDate = datesFilter.getOpenTime(resolutionMin: resolution)
        finalDates.append(openDate)
        var nextDate = openDate
        let timeDividerMinutes = getTimeDivider()
        
         
        //run on each date from the first one, and add the timedivider to get array of dates
        //stop when added date is larger than now
        //12 is max interval
        for _ in 0..<12
        {
           
           let newdate=datesFilter.getDateInterval(forDate: nextDate, minutes: timeDividerMinutes)
 
           if (!datesFilter.isDateLaterThanNow(withDate: newdate))
           {
          
          
            finalDates.append(newdate)
            nextDate=newdate
           }
           else
           { return finalDates }
            
        }
 
        return finalDates
 
        
    }
    
    
    //every how many minutes we show a label since the starting date OF THE SPAN
    func getTimeDivider()->Int
    {
        let defaultDistance = 12
        
        //1H / MINUTES
        if(resolution<=60){return resolution/defaultDistance}
        //1D
        else if (resolution <= 60*24) { return 120}
        //3D, 5D
        else if (resolution <= 60*24*5) { return 60*24}
        //1M
        else if (resolution <= 60*24*31) { return 60*24*7}
        //1Y
        else if (resolution <= 60*24*31*12) { return 60*24*31}
        
        
        return resolution/defaultDistance
    }








    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
        



}

