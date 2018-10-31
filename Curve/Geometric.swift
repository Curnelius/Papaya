//
//  Geometric.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit


class Geometric {


    var Gdates = [Date]()
    var Gpoints = [CGFloat]()
    var Gsize:CGSize!
    var Gresolution:Int!
    var GmaxValue:CGFloat!
    private let datesFilters = DatesFilter()
 




    func initWith(dates:[Date],values:[CGFloat],size:CGSize,resolutionInMin:Int,maxValue:CGFloat)
    {
        Gdates=dates
        Gpoints=values
        Gsize=size
        Gresolution=resolutionInMin
        GmaxValue=maxValue
  
    }
    
    func getCurveValuesInPixels()->[CGPoint]
    {
        
        var finalCurve = [CGPoint]()
        
        let x = getXValues()
        let y = getYValues()
        let minElements  = min(x.count, y.count)
        
      
        for i in 0..<minElements
        {
            let point = CGPoint(x:x[i], y: y[i])
            finalCurve.append(point)
        }
        return finalCurve
    }

 
    private func getXValues() -> [CGFloat]
    {
        let relativeT=datesFilters.getRelativeTimes(resolutionMin: Gresolution, withDates: Gdates)
        var TLocations = [CGFloat]()
        for fraction in relativeT
        {
            TLocations.append(fraction*Gsize.width)
        }
        return TLocations
    }
    
    
    private func getYValues()->[CGFloat]
    {
        
        var max:CGFloat = Gpoints.max()!
        GmaxValue == 0 ? (max=max) : (max=GmaxValue)
        
        let span:CGFloat = max
        var Vlocations = [CGFloat]()
        
        for value in Gpoints
        {
            let fvalue=(value/span)*Gsize.height //measured from top down
            Vlocations.append(fvalue)
        }
        return Vlocations
    }


 









}
