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
    
    
    
    
    
    
    
    
    
    
    // ** graph values
    
    
    //return  numbers 0-1 which relative to the whole time span, so  for 8-10am, 9am is 0.5
    func getRelativeTime(resolutionMin:Int,withDate:Date, endDate:Date)->CGFloat
    {
        //calculate in seconds resolution
        
        let timeSpanSec:CGFloat  = 60.0*CGFloat(resolutionMin)
     
  
     
        let delta:Int = withDate.seconds(from: self.getOpenTime(resolutionMin: resolutionMin, endDate: endDate)) //extension used
            
            if ( delta >= 0 )
            {
                let relative = CGFloat(delta) / timeSpanSec
                return relative
        
            }
        return -1

  
        
        
    }
    
    
    
    //**!!!
    func getDatesAsStrings(forDates:[Date], andResolution:Int, maxXAxisValues:Int)->[String]
    {
        
        
        
        var stringsTimeArray = [String]()
        for date in forDates
        {
            
            let calendar = Calendar.current
            let min = Calendar.current.component(.minute, from: date)
            var hour = Calendar.current.component(.hour, from: date)
            let day = Calendar.current.component(.weekday, from: date)
            let month = Calendar.current.component(.day, from: date)
            let weekdaySymbols = calendar.weekdaySymbols
 
            //round up minutes only multiplies of 5
            let minMultiplies:Int = andResolution/maxXAxisValues
            var rounded:Int = (min+minMultiplies-1)/minMultiplies*minMultiplies
            if(rounded==60){
                rounded=0
                hour+=1
                if(hour == 23){ hour = 0}
            }
            
            //minutes string digit
            var minuteString = String(format: "%d", rounded)
            if (rounded<10){minuteString = String(format: "0%d", rounded)}
            
            
            
 
            
            //min
            if (andResolution <= 60) { stringsTimeArray.append(String(format: "%d:%@", hour,minuteString)) }
            //day
            else if (andResolution <= 60*24) { stringsTimeArray.append(String(format: "%d:00", hour)) }
            //3-5 days
            else if (andResolution <= 60*24*5) { stringsTimeArray.append(String(format: "%@", weekdaySymbols[day-1])) }
            //month
            else if (andResolution <= 60*24*31) { stringsTimeArray.append(String(format: "%d", month)) }
            
        }
        
        
        return stringsTimeArray
        
    }
    
    
    
    
    
    
    
    
    //**axis
    
    
    
    
    
    //get  list of dates by resolution , time divider, and number of values to show on axis (with rounded minutes)
    func getListOfRoundedDates(endDate:Date, resolution:Int, maximumValues:Int)->[Date]
    {
        
        
        var finalDates = [Date]()
        let openDate = self.getOpenTime(resolutionMin: resolution,endDate: endDate)
        var nextDate = openDate
        let timeDividerMinutes = getTimeDivider(resolution:resolution, maximumValues:maximumValues)
        
        
        //run on each date from the first one, and add the timedivider to get array of dates
        //add relevant dates when they are rounded by minute - to final array
        //stop when added date is larger than now
       
         finalDates.append(self.getRoundedDate(date: openDate, resolution: resolution, maxXValues: maximumValues))
        
        for _ in 0..<maximumValues-1
        {
            //add time interval to get a new date
            let newdate=self.getDateInterval(forDate: nextDate, minutes: timeDividerMinutes)
            //if date is not later than now
            if (newdate < endDate)
            {
                
                finalDates.append(self.getRoundedDate(date: newdate, resolution: resolution, maxXValues: maximumValues))
                nextDate=newdate
            }
            else
            { return finalDates }
            
        }
        
        return finalDates
        
        
    }
    
    
    //every how many minutes - we  jump (show a label) since the starting date of the resolution to end date
    func getTimeDivider(resolution:Int, maximumValues:Int)->Int
    {
        let defaultDistance:Int = maximumValues
        
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
    

    
    //round a date's minutes by our resolution and maximum labels allowed to show
    func getRoundedDate(date:Date,resolution:Int, maxXValues:Int)->Date
    {
        //round up the minutes by relationship between resolution(span) and number of values to show
        let roundMinutesBy:Int = resolution/maxXValues
        //less than a minute jumps is not allowed
        if(roundMinutesBy == 0){return Date()}
        
        
        
        //read components to calculate the rounding
        let min = Calendar.current.component(.minute, from: date)
        let hour = Calendar.current.component(.hour, from: date)
        let rounded:Int = (min+roundMinutesBy-1)/roundMinutesBy*roundMinutesBy
        var setHours:Int = hour
        var setMin:Int = rounded

        if(rounded >= 60) { setMin = 0; setHours+=rounded/60 }
        if(setHours >= 24) {setHours = (hour+rounded/60)-24 }

        
        return Calendar.current.date(bySettingHour:setHours, minute: setMin, second: 0, of: date)!
        
       
   
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //general
    
    
    //return first date for a certain resolution
    func getOpenTime(resolutionMin:Int, endDate:Date) ->Date
    {
        let calendar = Calendar.current
        let openDateForSpan = calendar.date(byAdding: .minute, value:-1*resolutionMin  , to: endDate)
         return openDateForSpan!
    }
    
    
    //return interval for a date
    func getDateInterval(forDate:Date,minutes:Int)->Date
    {
        
        return  forDate.addingTimeInterval(TimeInterval(1.0*CGFloat(minutes) * 60.0))

    }
    
   
    
    
    
    
    
    

    
    
 

    
    

}
