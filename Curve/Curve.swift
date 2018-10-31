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
    private var graphHeight:CGFloat!
    private var curveSize:CGRect!
    private  let geometric = Geometric()

 

 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        //self  UI
        self.layer.cornerRadius = 20.0
        self.backgroundColor=UIColor.white
        
        //graph geometrics
         graphHeight = 0.7*self.frame.height
         curveSize=CGRect(x:0, y:(self.frame.height-graphHeight )/2.0, width:self.frame.width, height: graphHeight)
        
        
        
        //add title
        curveTitles = CurveTitle(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.15*self.frame.height))
        self.addSubview(curveTitles)
 
    }
    
    func addCurve(name:String,data:[[String:Any]],resolutionInMin:Int,Yresolution:CGFloat,fillColor:UIColor,lineColor:UIColor)
    {
 
        
        geometric.initWith(pairs:data, size: curveSize.size,resolutionInMin:resolutionInMin, maxValue:Yresolution)
        let finalPoints = geometric.getCurvePairsInPixels()
        
        //add curve
        let graph = Graph(frame: curveSize,points:finalPoints,fillColor:fillColor,lineColor:lineColor)
        self.addSubview(graph)
        graphs.append([name:graph])
        graph.drawCurve()

    }
    func removeCurve(name:String)
    {
       self.getGraphWithName(name: name).removeFromSuperview()
    }
    
    func bringCurveToFront(name:String)
    {
        let thiscurve:UIView = self.getGraphWithName(name: name)
        self.bringSubviewToFront(thiscurve)
    }
    
    func getGraphWithName(name:String)->UIView
    {
        for dic in graphs
        {
            let graphName = Array(dic.keys)[0]
            let graphView = Array(dic.values)[0]
            if ( graphName == name) {
                
                return graphView
            }
        }
        return UIView()
    }
    
   
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
