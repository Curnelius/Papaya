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
    var persistanceMaxValueInData:CGFloat = 0
    private let datesFilters = DatesFilter()
    private let filter  = DatesFilter()





    
    func getDatesLocationsPairs()->[[String:CGFloat]]
    {
        return  filter.getStringDateAndLocation(endDate: Date(), resolution: Gresolution, maximumValues: GmaxXAxisValues)

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


 

    
 
    private func getMaxValue()->CGFloat
    {
        //calculate maximum value only once in a life time. any added graph will be drawn relative to this scale
        //do not recalculate according to a new datapair. First data pair determine our Y scale.
        if(persistanceMaxValueInData != 0 ) {return persistanceMaxValueInData}
        
        let maxValue = dataPairs.map { $0["value"] as! CGFloat }.max()!
        persistanceMaxValueInData=maxValue
        return maxValue


    }







}
