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
    var CurvePairsInPixels = [CGPoint]()
    var Gsize:CGSize!
    var Gresolution:Int!
    var GmaxValue:CGFloat!
    var endDate:Date!
    var GmaxXAxisValues:Int!
    var persistanceMaxValueInData:CGFloat = 0
    private let datesFilters = DatesFilter()
    private let filter  = DatesFilter()



    
 
 

    
    func getPointOnPath(touch:CGPoint)->MovingPoint
    {

    
        var movingP:MovingPoint
        
       
        //get pairs
        let pairs = CurvePairsInPixels
        let lockPrecentage:CGFloat=10.0
        let touchX:CGFloat=touch.x
        
        
        //no points
        movingP=MovingPoint.init(pointOnScreen:CGPoint(x: -50.0, y: -50.0), value:CGFloat(0), isPointOnCurve: false, date:getDateForPoint(point: CGPoint(x: touchX, y: 0.0)))
        
        if (pairs.count==0){return movingP}
        
        for index in 0..<pairs.count-1
        {
            
            let point1=pairs[index]
            let point2=pairs[index+1]
            
            
            //touch on line between 2 points
             if(touchX<point2.x && touchX>point1.x)
             {
                
                let slope = (point2.y-point1.y)/(point2.x-point1.x)
                let y = slope*(touchX-point1.x)+point1.y
                var p = CGPoint(x: touchX, y: y)
                
                //locking mechanism
                let distance1 = sqrt (  (p.x-point1.x)*(p.x-point1.x)+(p.y-point1.y)*(p.y-point1.y) )
                let distance2 = sqrt (  (p.x-point2.x)*(p.x-point2.x)+(p.y-point2.y)*(p.y-point2.y) )
                let lineLen =   distance1+distance2
                if(distance1<lockPrecentage*lineLen/100.0){p=point1}
                else if(distance2<lockPrecentage*lineLen/100.0){p=point2}

                
                movingP=MovingPoint.init(pointOnScreen: p, value: getMaxValue()*(p.y)/Gsize.height, isPointOnCurve: false, date: self.getDateForPoint(point: p))
                
                
              
 
                if( p==point1 || p==point2) {movingP.isPointOnCurve=true }
                
                return movingP

             }
 
         }
        
        


  
 
        
        return movingP
 
    }

    
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
        //handle single point
        if (finalCurve.count==1)
        {
            finalCurve.append(finalCurve[0])
            finalCurve[0]=CGPoint(x: 0, y: 0 )
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

 
    
    
    
    
    private func getDateForPoint(point:CGPoint)->Date
    {
       let relativeWidth = point.x/Gsize.width
       let relativeSpan = relativeWidth*CGFloat(Gresolution)
       let openDate=datesFilters.getOpenTime(resolutionMin: Gresolution, endDate: endDate, maxXValues: GmaxXAxisValues)
        let date = datesFilters.getDateInterval(forDate: openDate, minutes: Int(relativeSpan))
        return date
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
