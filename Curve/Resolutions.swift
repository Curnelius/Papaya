//
//  Resolutions.swift
//  Papaya
//
//  Created by ran T on 08/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation


//first we define how many values we show per screen width : maxXAxisValues
// then we define the resolution: currentXResolution, which is the span per 1 screen width, should be multiplies of : maxXAxisValues
// this value (currentXResolution) can be changed when user pick a new resolution
// this value only show the span per 1 screen width, but we can set the overall span to be multiple screens x2,x3 currentXResolution

struct CurveResolutions {
    
    var maxXAxisValues = 6
    var currentXResolution:Int = 24 // in min, must be multiply of maxXAxisValues, resolution is per screen wide
    var currentYResolution:Int = 0
    var resolutionMenuTitles =   ["10M","1H","1D","3D","5D","1M","MAX"]
    var scrollingScreens = 2
 
    
    
    
    
    
    func getDateStringFormat()->String
        
    {
        //min//hour
        if (currentXResolution <= 60*scrollingScreens) { return "HH:mm"}
            //day
        else if (currentXResolution <= 60*24*scrollingScreens) {return "HH:mm"}
            //3-5 days
        else if (currentXResolution <= 60*24*5*scrollingScreens) { return "EEE"   }
            //month
        else if (currentXResolution <= 60*24*31*scrollingScreens) { return "dd.MM" }
            //year
        else if (currentXResolution <= 60*24*31*12*scrollingScreens) { return "MMMM" }
        
        return "HH:mm"

    }

    
    
    mutating func setResolutionForString(selection:String)
    {
        if(selection == resolutionMenuTitles[0]) { currentXResolution = 24}
        else if(selection == resolutionMenuTitles[1]) { currentXResolution = 60}
        else if(selection == resolutionMenuTitles[2]) { currentXResolution = 60*24}
        else if(selection == resolutionMenuTitles[3]) { currentXResolution = 60*24*3}
        else if(selection == resolutionMenuTitles[4]) { currentXResolution = 60*24*5}
        else if(selection == resolutionMenuTitles[5]) { currentXResolution = 60*24*31}
     
    }
    
    
  
    
}



