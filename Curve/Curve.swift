//
//  Curve.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Curve: UIView,ResolutionMenuProtocol,TouchViewProtocol {
    
    
    
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
    private var touchView:TouchView!
    private var viewOnTop=0

    
 
 
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        
        
        //self  UI
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor=UIColor.white
        self.clipsToBounds=true
        
 
 
 
        //set  geometrics
        
        let titlesFrame=CGRect(x: 0, y: 0, width: self.frame.width, height: 0.185*self.frame.height)
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
        
        let menu = ResolutionMenu(frame: menuframe, textColor: UIColor.black, font: "LucidaGrande-Bold", list: resolutionMenuTitles, selection: 0)
        menu.delegate=self
        self.addSubview(menu)
 
        
        
      
        
        
        //add axises - now we add only dates which independent on data but on default resolution
        
        let axisLabelColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        Xaxis = XAxis(frame: axisXFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.updateXaxis(xAxis: geometric.getDatesLocationsPairs())
        Yaxis = YAxis(frame: axisYFrame, textColor: axisLabelColor, font:"LucidaGrande", stripHeight: bottomSpace)
        self.addSubview(Xaxis)
        self.addSubview(Yaxis)
        
 
        //get touches
        touchView = TouchView(frame: curveSize)
        touchView.delegate=self
        touchView.isUserInteractionEnabled=true
        self.addSubview(touchView)
        
 
        //marker
        marker = CurveMarker(frame: CGRect(x: -5.0, y: 0, width: 5.0, height: 5.0))
        touchView.addSubview(marker)
        
        
 
    
        
        
     }
    
    
    
    //touch moved delegate - move marker
    func TouchViewDelegate(touched: CGPoint) {
      
        //show marker
        marker.isHidden=false
        
        let pointDic = geometric.getPointOnPath(touch: touched)
        var finalPoint:CGPoint =  pointDic["pointOnScreen"] as! CGPoint
        let isOnGraph = pointDic["isPointOnCurve"] as! Bool
        let value = pointDic["value"] as! CGFloat
        let date = pointDic["date"] as! Date
        
        finalPoint.y=curveSize.height-finalPoint.y

        //set marker
        marker.center=finalPoint
        isOnGraph ? marker.mark():marker.unmark()
        
      
        let datefilter = DatesFilter()
        let stringDate = datefilter.getDateAsString(forDate: date, resolution: currentXResolution)
        curveTitles.subtitle.text = String(format: "%.2f, at %@", value,stringDate)
    
     }
    
    

    
    //tap delegate - bring to front
    func TouchViewDelegateTap() {
        
        
        var orderToGet=viewOnTop+1
        if(orderToGet==graphs.count){orderToGet=0}
        
        //find next view to bring to front
        //view.order is constant,"viewOnTop" changes to indicate who is showing
        for i in 0..<graphs.count{
            var dic = graphs[i]
            let name = dic["name"] as! String
            if(i==orderToGet){self.bringGraphToFront(name: name)}
        }
 
        
    }
    func TouchViewDelegateBeginEnd(state: String) {
        if(state=="begin"){}
        else{marker.isHidden=true}
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
            let viewOrder=view.order
            let data = dic["data"] as! [[String:Any]]
            let name = dic["name"] as! String
            let animation=dic["animation"] as! String
            let fill = view.curveFillColor
            let line = view.curveLineColor
            
            
            //remove view
            view.removeFromSuperview()
            //add new view
            let newGraph = addCurveView(name:name,data:data, fill: fill!, line: line!, animation:animation )
            //bring back order number to graph
            newGraph.order=viewOrder
            //update graphs array
            dic["view"]=newGraph
            graphs[i]=dic
            //update z's
            bringGraphToFront(name: name)

           }
        
     }
    
    
    func addNewCurve(name:String, data:[[String:Any]],fillColor:UIColor,lineColor:UIColor, animation:String)
    {
   
 
        //add curve
        let newGraphView=addCurveView(name:name,data:data, fill: fillColor, line: lineColor,animation:animation )
        newGraphView.order=graphs.count
 
        
        //add new curve to array
        var newGraph = [String:Any]()
        newGraph["view"]=newGraphView
        newGraph["name"]=name
        newGraph["data"]=data
        newGraph["animation"]=animation
        graphs.append(newGraph)

        
         bringGraphToFront(name: name)
        
        //update y axis , maximum value and curve locations will only be calculated according to first graph's data
        Yaxis.updateYaxis(yAxis: geometric.getYAxisPairs())
        Yaxis.layer.zPosition=1000
        
        
        
 

        
 
    }
    
    private func addCurveView(name:String,data:[[String:Any]],fill:UIColor, line:UIColor,animation:String)->Graph
    {

        //update geometric
        geometric.dataPairs=data
        
        //add curve
        let graph = Graph(frame: curveSize,points:geometric.getCurvePairsInPixels())
        graph.curveFillColor=fill
        graph.curveLineColor=line
        self.addSubview(graph)
        
        
        
        graph.startDrawingCurve(duration: 1.5, animation:animation )

        return graph
        
    }
    
    
 
   
    
    func bringGraphToFront(name:String)
    {
        
        for i in 0..<graphs.count{
            
            var dic = graphs[i]
            let view = dic["view"] as! Graph
            let graphName = dic["name"] as! String
            let data = dic["data"] as! [[String:Any]]
            
            if(graphName==name)
            {
              //bring graph to front to front
              self.bringSubviewToFront(view)
              //bring touch to front
              self.bringSubviewToFront(touchView)
             
                
            //update reference
            viewOnTop=view.order
              
              //set current data
              geometric.dataPairs=data
              //setup final pixels pairs to let indicator run on top curve
              geometric.CurvePairsInPixels = geometric.getCurvePairsInPixels()
              return
            }

        }
        
        
    }
   
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
 
    

}
