//
//  DatesFilter.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit


class DatesFilter {
    
    
    
    
    //returns all dates inside the requested period (e.g 60 minutes)
    func getDatesForLast(minutes:Int, withDates:[Date])->[Date]
    {
        var sortDates = [Date]()
        
        for localDate  in withDates
        {
            let date:Date = localDate
            let currentDate = Date()
            let delta:Int = currentDate.minutes(from: localDate)
            if( delta <= minutes){ sortDates.append(date)}
        }
        return sortDates
    }
    
    
    
    
    //return  numbers 0-1 which relative to the whole time span, so  for 8-10am, 9am is 0.5
    func getRelativeTime(resolutionMin:Int,withDate:Date)->CGFloat
    {
        //calculate in seconds resolution
        
        let timeSpanSec:CGFloat  = 60.0*CGFloat(resolutionMin)
     
  
     
            let delta:Int = withDate.seconds(from: self.getOpenTime(resolutionMin: resolutionMin)) //extension used
            
            if ( delta >= 0 )
            {
                let relative = CGFloat(delta) / timeSpanSec
                return relative
        
            }
        return -1

  
        
        
    }
    
    
    func getOpenTime(resolutionMin:Int) ->Date
    {
        let openDateForSpan = Date().addingTimeInterval(TimeInterval(-1.0*CGFloat(resolutionMin) * 60.0))
        return openDateForSpan
    }
    
    
    
    
    
    
    
    

    
    
 

    
    

}
