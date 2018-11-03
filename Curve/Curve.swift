//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView,ResolutionMenuProtocol {
    
    
    
    var curveTitles:CurveTitle!
    var resolutionMenuTitles = ["10M","1H","1D","3D","5D","1M"]
    var cornerRadius:CGFloat = 24.0
    var dataPairs = [[String:Any]]()
    var graphFill:UIColor!
    private var graphs = [[String:UIView]]()
    private var curveSize:CGRect!
    private  let geometric = Geometric()
    private let maxXAxisValues = 6
    private var currentXResolution:Int = 24 // in min, must be multiply of maxXAxisValues
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
        let graphHeight = 0.7 * ( frame.height-bottomSpace-curveTitles.frame.size.height )
        curveSize=CGRect(x:0, y:frame.height-bottomSpace-graphHeight, width:self.frame.width, height: graphHeight)
        
        
        
        
        
       
        
        
        //add axises - now we add only dates which independent on data but on default resolution
        let filter  = DatesFilter()
        let dateLocationPairs = filter.getStringDateAndLocation(endDate: Date(), resolution: currentXResolution, maximumValues: maxXAxisValues)
        let axisXFrame=CGRect(x: 0, y:frame.height-bottomSpace, width: frame.width, height: bottomSpace)
        let axisYFrame=CGRect(x: 0, y:curveSize.origin.y, width: 2*bottomSpace, height: curveSize.height)
        let axisLabelColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)

        Xaxis = XAxis(frame: axisXFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.updateXaxis(xAxis: dateLocationPairs)
        self.addSubview(Xaxis)
        
        Yaxis = YAxis(frame: axisYFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
         self.addSubview(Yaxis)
        
 
        
        
        
        
        //add menu
        let menuWidth=0.5*frame.width
        let menuHeight=curveTitles.frame.height/2.0
        let menuframe=CGRect(x: frame.width-menuWidth, y:curveTitles.frame.maxY, width: menuWidth, height: menuHeight)
        let menu = ResolutionMenu(frame: menuframe, textColor: UIColor.black, font: "LucidaGrande", list: resolutionMenuTitles, selection: 0)
        menu.delegate=self
        self.addSubview(menu)
        
        
     }
    
    
    
    
    
    func ResolutionMenuDelegate(selected: String) {
        
        
        
        //10M
        if (selected == resolutionMenuTitles[0]) { currentXResolution=24}
        //1H
        else if (selected == resolutionMenuTitles[1]) {currentXResolution=60}
        //1D
        else if (selected == resolutionMenuTitles[2]) {currentXResolution=60*24}
        //3D
        else if (selected == resolutionMenuTitles[3]) {currentXResolution=60*24*3}
        //5D
        else if (selected == resolutionMenuTitles[4]) {currentXResolution=60*24*5}
        
        
        updateCurve()
    }
    
    
    
    
    
    
    
    
    
    
    
    //*** curve
    
    func updateCurve()
    {
        for v in graphs{
            let view =  Array(v.values)[0]
            view.removeFromSuperview()
        }
        
        self.addCurve(name: "ran", data:dataPairs , fillColor:graphFill , lineColor: graphFill)
    }
    
    
    func addCurve(name:String,data:[[String:Any]],fillColor:UIColor,lineColor:UIColor)
    {
 
        dataPairs=data
        graphFill=fillColor
        
        let filter  = DatesFilter()
        let dateLocationPairs = filter.getStringDateAndLocation(endDate: Date(), resolution: currentXResolution, maximumValues: maxXAxisValues)
        
     
        //update geometric
        geometric.initWith(pairs:data, size: curveSize.size,resolutionInMin:currentXResolution, maxValue:CGFloat(currentYResolution), lastDate: Date(), maxXAxisValues:maxXAxisValues )
        let finalPoints = geometric.getCurvePairsInPixels()
        
        //add curve
        let graph = Graph(frame: curveSize,points:finalPoints,fillColor:fillColor,lineColor:lineColor)
        self.addSubview(graph)
        graphs.append([name:graph])
        graph.startDrawingCurve(duration: 1.0)
        
        //update x y axis 
        Yaxis.updateYaxis(yAxis: geometric.getYAxisPairs())
        Xaxis.updateXaxis(xAxis: dateLocationPairs)

        
 
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
