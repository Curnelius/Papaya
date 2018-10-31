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
    
    
    func getDatesAsStrings(forDates:[Date], andResolution:Int)->[String]
    {
        
        var stringsTimeArray = [String]()
        for date in forDates
        {
            
            let calendar = Calendar.current
            let min = Calendar.current.component(.minute, from: date)
            let hour = Calendar.current.component(.hour, from: date)
            let day = Calendar.current.component(.weekday, from: date)
            let month = Calendar.current.component(.day, from: date)
            let weekdaySymbols = calendar.weekdaySymbols
 
            
            
 
         
            
            //min
            if (andResolution <= 60) { stringsTimeArray.append(String(format: "%d:%d", hour,min)) }
            //day
            else if (andResolution <= 60*24) { stringsTimeArray.append(String(format: "%d:00", hour)) }
            //3-5 days
            else if (andResolution <= 60*24*5) { stringsTimeArray.append(String(format: "%@", weekdaySymbols[day-1])) }
            //month
            else if (andResolution <= 60*24*31) { stringsTimeArray.append(String(format: "%d", month)) }
            
        }
        
        
        return stringsTimeArray
        
    }
    
    
    
    
    
    //return first date for a certain resolution
    func getOpenTime(resolutionMin:Int) ->Date
    {
        let calendar = Calendar.current
        let openDateForSpan = calendar.date(byAdding: .minute, value:-1*resolutionMin  , to: Date())
         return openDateForSpan!
    }
    
    
    //return interval for a date
    func getDateInterval(forDate:Date,minutes:Int)->Date
    {
        
        return  forDate.addingTimeInterval(TimeInterval(1.0*CGFloat(minutes) * 60.0))

    }
    
    func isDateLaterThanNow(withDate:Date)->Bool
    {
 
        if(withDate > Date()) {return true}
        else {return false }
    }
    
    
    
    
    
    
    
    

    
    
 

    
    

}
