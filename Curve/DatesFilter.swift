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
    
    
    
    
    
    func getPairsOfDatesLocations(openDate:Date,endDate:Date,jumps:Int,span:Int)->[[Date:CGFloat]]
    {
        
        var finalArray = [[Date:CGFloat]]()
        var nextDate = openDate
        while (nextDate<endDate)
        {
            //using extension class for Date
            let delta:Int = nextDate.seconds(from: openDate)
        
            
            if ( delta >= 0 )
            {
                let relative = CGFloat(delta) / CGFloat(span)
                finalArray.append([nextDate:relative])
            }
            
            //add time interval to get a new date
            nextDate=nextDate.addingTimeInterval(TimeInterval(1.0*CGFloat(jumps) * 60.0))
           
  
 
        }
        
        return finalArray
        
    }
 
    
    
    
    
    
    
    //return interval for a date
    func getDateInterval(forDate:Date,minutes:Int)->Date
    {
        
        return  forDate.addingTimeInterval(TimeInterval(1.0*CGFloat(minutes) * 60.0))

    }
    
   
    
    
    
    
    
    

    
    
 

    
    

}
