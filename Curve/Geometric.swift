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
    private let datesFilters = DatesFilter()
 




    func initWith(dates:[Date],points:[CGFloat],size:CGSize)
    {
        Gdates=dates
        Gpoints=points
        Gsize=size
 
        
    }


    //map dates and values into the screen spacw (w/h)
    func getPoints()->[[CGFloat]]
    {
        
        return [[1,1]]
       
    }
    
    func getXValues(resolutionMin:Int) -> [CGFloat]
    {
        
        let relativeT=datesFilters.getRelativeTimes(resolutionMin: resolutionMin, withDates: Gdates)
        var TLocations = [CGFloat]()
        for fraction in relativeT
        {
            TLocations.append(fraction*Gsize.width)
        }
        
        return TLocations
    }
    
    func getYValues()->[CGFloat]
    {
        let min:CGFloat = Gpoints.min()!
        let max:CGFloat = Gpoints.max()!
        let span:CGFloat = max-min
        var Vlocations = [CGFloat]()
        for value in Gpoints
        {
            Vlocations.append((value/span)*Gsize.height)
        }
        return Vlocations
    }


 



















}
