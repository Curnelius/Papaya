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
    var resolutionMenuTitles = ["10M","1H","1D","3D","5D","1M"]

    

}
