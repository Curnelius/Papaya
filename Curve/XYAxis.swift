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
    var pairs = [[String:Any]]()
    var resolution:Int!
    let datesFilter = DatesFilter ()
    
    
    
    
    init (frame : CGRect,data:[[String:Any]], textColor:UIColor, resolutionMin:Int)
    {

       pairs=data
       labelColor=textColor
       resolution=resolutionMin
       super.init(frame : frame)
        
        
 
        
    }
    
    
    
    //**** do we need data() here ????????
    
    
    private func setAxis()
    {
        print(getListOfDates())
    }
    
    
    private func getListOfDates()->[Date]
    {
        
        
        var finalDates = [Date]()
        let openDate = datesFilter.getOpenTime(resolutionMin: resolution)
        finalDates.append(openDate)
        var nextDate = openDate
        var timeDividerMinutes = getTimeDivider()
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
        else if (resolution <= 60*12) { return 60}
        //3D
        else if (resolution <= 60*36) { return 60*12}
        //5D
        else if (resolution <= 60*60) { return 60*12}
        //1M
        else if (resolution <= 60*12*31) { return 60*12*7}
        //1Y
        else if (resolution <= 60*12*31*12) { return 60*12*31}
        
        
        return resolution/defaultDistance
    }








    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
        



}

