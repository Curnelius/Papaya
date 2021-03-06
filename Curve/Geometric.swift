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
    var numScreensToScroll:Int!
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

    
    
    
    
    
    //1
    func getDatesLocationsPairs()->[[Date:CGFloat]]
    {
        return  filter.getPairsOfDatesLocations(openDate: getOpenDate(), endDate: endDate, jumps: getJumps(),span: getSpan())

    }
    
    
    
    
    //2 for curve draw returns locations on screen of x and y points, without values (dates/yvalue)
    func getCurvePairsInPixels()->[CGPoint]
    {
        
        var finalCurve = [CGPoint]()
        
        
        
        for pair in dataPairs
        {
            let date = pair["date"] as! Date
            let value = pair["value"] as! CGFloat
            
            let delta:Int = date.seconds(from: getOpenDate())
            let relative = CGFloat(delta) / CGFloat(getSpan())


            
            if(relative != -1 )
            {
                let x = getXValue(relativeT: relative)
                let y = getYValue(value: value)
                let point=CGPoint(x: x, y: y)
                finalCurve.append(point)
            }
        }
        //handle single point
        if (finalCurve.count==1)
        {
            let onePointWidth:CGFloat = 3.0
            finalCurve.append(finalCurve[0])
            finalCurve[0]=CGPoint(x: finalCurve[1].x-onePointWidth, y: finalCurve[1].y)
 
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
       let openDate=getOpenDate()
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
       //for multiple graphs we check for the highest top of all of them
        //if first max is 10, and second max is 5, we draw both according to max 10
        //if first max is 10 then later second max is 20, we calculate for 20 and delegate an update

         return persistanceMaxValueInData


    }



    //check if a new graph has higher max than last max AND SET it
    func isHigherMax(Newdata:[[String:Any]])->Bool
    {
         let NewMaxValue = Newdata.map { $0["value"] as! CGFloat }.max()!
        
        if(NewMaxValue>persistanceMaxValueInData) {
            persistanceMaxValueInData=NewMaxValue
            return true
            
        }
        return false
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getOpenDate()->Date
    {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value:-1*Gresolution  , to: endDate)!
        
    }
    
    
    
    func getJumps()->Int
    {
        let defaultDistance:Int = GmaxXAxisValues
        
        //1H / MINUTES
        if(Gresolution<=60*numScreensToScroll){return (Gresolution/numScreensToScroll)/defaultDistance}
            //1D
        else if (Gresolution == 60*24*numScreensToScroll) { return 60*4}
            //3D, 5D
        else if (Gresolution == 60*24*5*numScreensToScroll) { return 60*24}
            //1M
        else if (Gresolution == 60*24*31*numScreensToScroll) { return 60*24*7}
            //1Y
        else if (Gresolution == 60*24*31*12*numScreensToScroll) { return 60*24*31}
 
        
        //case of MAX span
        return Gresolution/defaultDistance
    }
    
    
    func getSpan()->Int
    {
        
        return   endDate.seconds(from: getOpenDate())
    }
    
    
    //not open date, just first date
    func getFirstDateForData()->Date
    {
        return dataPairs.first!["date"] as! Date
    }
    //not close date, just last date
    func getLastDateForData()->Date
    {
        return dataPairs.last!["date"] as! Date
    }


}
