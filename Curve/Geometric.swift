//
//  Geometric.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit



//get x points
//run on data pairs of dates and values
//for each date (only inside the span defined by resolution) get his relative position on screen
//then get this date's value also as relative point in screen

class Geometric {


    var dataPairs = [[String:Any]]()
    var Gsize:CGSize!
    var Gresolution:Int!
    var GmaxValue:CGFloat!
    var endDate:Date!
    var GmaxXAxisValues:Int!
    private let datesFilters = DatesFilter()
 




    func initWith(pairs:[[String:Any]],size:CGSize,resolutionInMin:Int,maxValue:CGFloat, lastDate:Date, maxXAxisValues:Int)
    {
        dataPairs=pairs
        Gsize=size
        Gresolution=resolutionInMin
        GmaxXAxisValues=maxXAxisValues
        GmaxValue=maxValue
        endDate=lastDate
  
    }
    
    
    
    //for curve draw returns locations on screen of x and y points, without values (dates/yvalue)
    func getCurvePairsInPixels()->[CGPoint]
    {
        
        var finalCurve = [CGPoint]()
        
        
        
        for pair in dataPairs
        {
            let date = pair["date"] as! Date
            let value = pair["value"] as! CGFloat
            
            //get a number that present a date relative position to our span, so 11am is 0.5 in a  10-12am span.
            // -1 means the date is outside the span and will not be counted
            let relativeTime = datesFilters.getRelativeTime(resolutionMin: Gresolution, withDate: date, endDate: endDate, maxXValues: GmaxXAxisValues)
            if(relativeTime != -1 )
            {
                let x = getXValue(relativeT: relativeTime)
                let y = getYValue(value: value)
                let point=CGPoint(x: x, y: y)
                finalCurve.append(point)
            }
        }
        
        
        return finalCurve

 
    }
    
    
    //get yaxis real values and location
    func getYAxisPairs()->[[CGFloat:CGFloat]]
    {
        let numYValues = 5
        var pairsFinal = [[CGFloat:CGFloat]]()
        let maximuma = self.getMaxValue()
        let jumps = maximuma/CGFloat(numYValues)
        let jumpsRounded = jumps/10.0*10.0 //jumps < 1 ? 0.1:
        var lastPointOnScale:CGFloat=0.0
        for _ in 0..<numYValues
        {
            let newPointOnScale=lastPointOnScale+jumpsRounded
            let relatedPosition=(newPointOnScale/maximuma)
            if (newPointOnScale<=maximuma) {
                pairsFinal.append([newPointOnScale:relatedPosition])
                lastPointOnScale=newPointOnScale
            }
        }
        
        return pairsFinal
    }

 
    private func getXValue(relativeT:CGFloat) -> CGFloat
    {
        return relativeT*Gsize.width
    }
    
    
    private func getYValue(value:CGFloat)->CGFloat
    {
        var max:CGFloat = getMaxValue()
        GmaxValue == 0 ? (max=max) : (max=GmaxValue)
        return (value/max)*Gsize.height //measured from top down
    }


 

    
 
    func getMaxValue()->CGFloat
    {
        
        let maxValue = dataPairs.map { $0["value"] as! CGFloat }.max()!
        return maxValue


    }







}
