//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView {
    
    
    
    var curveTitles:CurveTitle!
    private var graphs = [[String:UIView]]()
 

 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        //self  UI
        self.layer.cornerRadius = 20.0
        self.backgroundColor=UIColor.white
        
        
        
        //add title
        curveTitles = CurveTitle(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.15*self.frame.height))
        self.addSubview(curveTitles)
        
        
    }
    
    func addGraph(name:String,points:[[Date:CGFloat]],lineColor:UIColor,fillColor:UIColor)
    {
        let graph = Graph(lineColor: lineColor, fillColor: fillColor, size: CGSize(width: frame.width, height: frame.height/2.0))
        graphs.append([name:graph])
        self.addSubview(graph)
    }
    
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
