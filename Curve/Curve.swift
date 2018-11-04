//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView,ResolutionMenuProtocol,GraphProtocol {
    
    
    
    var curveTitles:CurveTitle!
    var resolutionMenuTitles = ["10M","1H","1D","3D","5D","1M"]
    var cornerRadius:CGFloat = 24.0
    private var graphs = [[String:Any]]()
    private var curveSize:CGRect!
    private  let geometric = Geometric()
    private let maxXAxisValues = 6
    private var currentXResolution:Int = 24 // in min, must be multiply of maxXAxisValues
    private let currentYResolution:Int = 0
    private var Xaxis:XAxis!
    private var Yaxis:YAxis!
    private var marker:CurveMarker!

    
 
 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        
        //self  UI
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor=UIColor.white
        self.clipsToBounds=true
        
 
 
 
        //set  geometrics
        
        let titlesFrame=CGRect(x: 0, y: 0, width: self.frame.width, height: 0.175*self.frame.height)
        let bottomSpace = 0.125*self.frame.height
        let graphHeight = 0.7 * ( frame.height-bottomSpace-titlesFrame.size.height )
        curveSize=CGRect(x:0, y:frame.height-bottomSpace-graphHeight, width:self.frame.width, height: graphHeight)
        let axisXFrame=CGRect(x: 0, y:frame.height-bottomSpace, width: frame.width, height: bottomSpace)
        let axisYFrame=CGRect(x: 0, y:curveSize.origin.y, width: bottomSpace, height: curveSize.height)
        let menuWidth=0.5*frame.width
        let menuHeight=titlesFrame.height/2.0
        let menuframe=CGRect(x: frame.width-menuWidth, y:titlesFrame.maxY, width: menuWidth, height: menuHeight)
        
        
 
        
        //set geometrics
        
        geometric.Gsize=curveSize.size
        geometric.Gresolution=currentXResolution
        geometric.GmaxValue=CGFloat(currentYResolution)
        geometric.GmaxXAxisValues=maxXAxisValues
        geometric.endDate=Date()
        
        
        
        //add title
        
        curveTitles = CurveTitle(frame:titlesFrame  )
        self.addSubview(curveTitles)
        
        
        //add menu
        
        let menu = ResolutionMenu(frame: menuframe, textColor: UIColor.black, font: "LucidaGrande", list: resolutionMenuTitles, selection: 0)
        menu.delegate=self
        self.addSubview(menu)
 
        
        
      
        
        
        //add axises - now we add only dates which independent on data but on default resolution
        
        let axisLabelColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        Xaxis = XAxis(frame: axisXFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.updateXaxis(xAxis: geometric.getDatesLocationsPairs())
        Yaxis = YAxis(frame: axisYFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
        self.addSubview(Xaxis)
        self.addSubview(Yaxis)
        
 
        
 
        
 
        
        
     }
    
    
    
    func GraphDelegate(touched: CGPoint) {
      
        var finalPoint:CGPoint =  geometric.getPointOnPath(touch: touched)
        finalPoint.y=curveSize.height-finalPoint.y

        marker.center=finalPoint
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
        //1M
        else if (selected == resolutionMenuTitles[5]) {currentXResolution=60*24*31}
        
        
        geometric.Gresolution=currentXResolution
        
        //update x axis
        Xaxis.updateXaxis(xAxis: geometric.getDatesLocationsPairs())

        
        updateCurves()
    }
    
    
    
    
    
    
    
    
    
    
    
    //*** curve
    
    func updateCurves()
    {
        for i in 0..<graphs.count{
            
            var dic = graphs[i]
            let view = dic["view"] as! Graph
            let data = dic["data"] as! [[String:Any]]
            let animation=dic["animation"] as! String
            let fill = view.curveFillColor
            let line = view.curveLineColor
            
            
            //remove view
            view.removeFromSuperview()
            //add new view
            let newGraph = addCurveView(data:data, fill: fill!, line: line!, animation:animation )
            //update graphs array
            dic["view"]=newGraph
            graphs[i]=dic

           }
        
     }
    
    
    func addCurve(name:String, data:[[String:Any]],fillColor:UIColor,lineColor:UIColor, animation:String)
    {
   
 
        //add curve
        let newGraphView=addCurveView(data:data, fill: fillColor, line: lineColor,animation:animation )
        
        
        //add new curve to array
        var newGraph = [String:Any]()
        newGraph["view"]=newGraphView
        newGraph["name"]=name
        newGraph["data"]=data
        newGraph["animation"]=animation
        graphs.append(newGraph)
        
        //set basic curve to geometric calculations
        //add marker to first curve
        if(graphs.count==1){
            geometric.baseDataPairs=data
            //marker
            marker = CurveMarker(frame: CGRect(x: 0, y: 0, width: 5.0, height: 5.0))
            marker.layer.zPosition=1000
            newGraphView.addSubview(marker)
 
        }
        
        //update y axis , maximum value and curve locations will only be calculated according to first graph's data
        Yaxis.updateYaxis(yAxis: geometric.getYAxisPairs())
        Yaxis.layer.zPosition=1000
        
        
        
 

        
 
    }
    
    private func addCurveView(data:[[String:Any]],fill:UIColor, line:UIColor,animation:String)->Graph
    {
        
        
        
        //update geometric
        geometric.dataPairs=data
        
        //add curve
        let graph = Graph(frame: curveSize,points:geometric.getCurvePairsInPixels())
        graph.curveFillColor=fill
        graph.curveLineColor=line
        graph.delegate=self
        graph.order=graphs.count
        self.addSubview(graph)
        graph.startDrawingCurve(duration: 1.5, animation:animation )
        
     
        
   
     

        
        
        return graph
        
    }
    
    
 
   
   
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
