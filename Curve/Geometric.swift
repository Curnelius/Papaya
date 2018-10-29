//
//  Geometric.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit

var Gdates = [Date]()
var Gpoints = [CGFloat]()
var Gsize:CGSize!
var timeScale:String!




func initWith(dates:[Date],points:[CGFloat],size:CGSize,scale:String)
{
    Gdates=dates
    Gpoints=points
    Gsize=size
    timeScale=scale
    
}


func getPoints()->[[CGFloat:CGFloat]]
{
    if(timeScale == "hour") {return getPointsPerMinute()}
    
    return [[1:1]]
}


private func getPointsPerMinute()->[[CGFloat:CGFloat]]
{
    
    for localDates in Gdates
    {
        
    }
    
    return [[1:1]]
}



