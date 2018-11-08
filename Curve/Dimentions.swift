//
//  Dimentions.swift
//  Papaya
//
//  Created by ran T on 08/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit

struct CurveDimensions {
    
    var frame:CGRect
    
    
    let deltas:CGFloat
    let titlesFrame:CGRect
    let bottomSpace:CGFloat
    let graphHeight:CGFloat
    let curveSize:CGRect
    let axisXFrame:CGRect
    let axisYFrame:CGRect
    let menuWidth:CGFloat
    let menuHeight:CGFloat
    let menuframe:CGRect
    let bubbleFrame:CGRect
    let markerFrame:CGRect
    
    
    
    init (frame:CGRect)
    {
        self.frame=frame
        
         deltas = 0.04*frame.size.width
         titlesFrame=CGRect(x:deltas, y:deltas, width: self.frame.width, height: 0.185*self.frame.height)
         bottomSpace = 0.125*self.frame.height
         graphHeight = 0.7 * ( frame.height-bottomSpace-titlesFrame.size.height )
         curveSize=CGRect(x:0, y:frame.height-bottomSpace-graphHeight, width:self.frame.width, height: graphHeight)
         axisXFrame=CGRect(x: 0, y:frame.height-bottomSpace, width: frame.width, height: bottomSpace)
         axisYFrame=CGRect(x: 0, y:curveSize.origin.y, width: bottomSpace, height: curveSize.height)
         menuWidth=0.5*frame.width
         menuHeight=titlesFrame.height/2.0
         menuframe=CGRect(x: frame.width-menuWidth, y:titlesFrame.maxY, width: menuWidth, height: menuHeight)
         bubbleFrame=CGRect(x:deltas, y: titlesFrame.maxY-titlesFrame.height/3.0, width: frame.width/5.0, height: titlesFrame.height/3.0)
         markerFrame=CGRect(x: -20.0, y: 0, width: 8.0, height: 8.0)
    }
}
