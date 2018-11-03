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
    var cornerRadius:CGFloat = 24.0
    private var graphs = [[String:UIView]]()
    private var curveSize:CGRect!
    private  let geometric = Geometric()
    private let maxXAxisValues = 6
    private let currentXResolution:Int = 12 // in min, must be multiply of maxXAxisValues
    private let currentYResolution:Int = 0
    private var Xaxis:XAxis!
    private var Yaxis:YAxis!

    
 
 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        
        //self  UI
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor=UIColor.white
        self.clipsToBounds=true
        
        
        
        
        
        
        //add title
        curveTitles = CurveTitle(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.175*self.frame.height))
        self.addSubview(curveTitles)
        
        
       
        
        
        
        //set graph geometrics
        let bottomSpace = 0.125*self.frame.height
        let graphHeight = 0.8 * ( frame.height-bottomSpace-curveTitles.frame.size.height )
        curveSize=CGRect(x:0, y:frame.height-bottomSpace-graphHeight, width:self.frame.width, height: graphHeight)
        
        
        
        
        //add axis - now we add only dates which independent on data but on default resolution
        let filter  = DatesFilter()
        let dateLocationPairs = filter.getStringDateAndLocation(endDate: Date(), resolution: currentXResolution, maximumValues: maxXAxisValues)
        let axisXFrame=CGRect(x: 0, y:frame.height-bottomSpace, width: frame.width, height: bottomSpace)
        let axisYFrame=CGRect(x: 0, y:curveSize.origin.y, width: 2*bottomSpace, height: curveSize.height)


        Xaxis = XAxis(frame: axisXFrame, textColor: UIColor.gray, font:"LucidaGrande", stripHeight: bottomSpace)
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.labelColor=UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        Xaxis.updateXaxis(xAxis: dateLocationPairs)
        self.addSubview(Xaxis)
        
        
        Yaxis = YAxis(frame: axisYFrame, textColor: UIColor.gray, font:"LucidaGrande", stripHeight: bottomSpace)
        Yaxis.labelColor=UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        self.addSubview(Yaxis)
        
 
        
         
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func addCurve(name:String,data:[[String:Any]],fillColor:UIColor,lineColor:UIColor)
    {
 
        
        geometric.initWith(pairs:data, size: curveSize.size,resolutionInMin:currentXResolution, maxValue:CGFloat(currentYResolution), lastDate: Date(), maxXAxisValues:maxXAxisValues )
        let finalPoints = geometric.getCurvePairsInPixels()
        
        //add curve
        let graph = Graph(frame: curveSize,points:finalPoints,fillColor:fillColor,lineColor:lineColor)
        self.addSubview(graph)
        graphs.append([name:graph])
        graph.startDrawingCurve(duration: 2.0)
        
        //update y axis 
        Yaxis.updateYaxis(yAxis: geometric.getYAxisPairs())
        
 
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
