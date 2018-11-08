//
//  CurveContainer.swift
//  Papaya
//
//  Created by ran T on 07/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveContainer: UIView,ResolutionMenuProtocol,TouchViewProtocol,GraphBubbleViewProtocol {

    
    var cornerRadius:CGFloat = 24.0
    var curveTitles:CurveTitle!

 
    
    
    
    
    private var Xaxis:XAxis!
    private var Yaxis:YAxis!
    private var marker:CurveMarker!
    private var bubbleView:GraphBubble!
    private var touchView:TouchView!
    
    private var viewOnTop=0
    
   
    //set   structs
    var dimensions:CurveDimensions!
    var resolutions:CurveResolutions!
    
    //set classes
    private  let geometric = Geometric()
    private var graphs = CurrentGraphsList()
    
    
    
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        

        //set dimensions and resolutions structures - to live forever
        
        dimensions = CurveDimensions(frame: frame)
        resolutions = CurveResolutions.init(maxXAxisValues: 6, currentXResolution: 24, currentYResolution: 0, resolutionMenuTitles: ["10M","1H","1D","3D","5D","1M"])
        
        
        //set geometrics constant vars, geometric is alive forever
        
        geometric.Gsize=dimensions.curveSize.size
        geometric.Gresolution=resolutions.currentXResolution
        geometric.GmaxValue=CGFloat(resolutions.currentYResolution)
        geometric.GmaxXAxisValues=resolutions.maxXAxisValues
        geometric.endDate=Date()
        
        
        
     
        addSubviews()
        

        
    }
    
    
    
    
    
    
    
    
    
    //add views
    func addSubviews()
    {
        //add title
        
        curveTitles = CurveTitle(frame:dimensions.titlesFrame  )
        self.addSubview(curveTitles)
        
        
        //add menu
        
        let menu = ResolutionMenu(frame: dimensions.menuframe, textColor: UIColor.black, font: "LucidaGrande-Bold", list: resolutions.resolutionMenuTitles, selection: 0)
        menu.delegate=self
        self.addSubview(menu)
        
        
        
        //add axises - now we add only dates which independent on data but on default resolution
        
        let axisLabelColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.0)
        Xaxis = XAxis(frame: dimensions.axisXFrame, textColor: axisLabelColor, font:"LucidaGrande")
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.updateXaxis(xAxis: geometric.getDatesLocationsPairs())
        Yaxis = YAxis(frame: dimensions.axisYFrame, textColor: axisLabelColor, font:"LucidaGrande" )
        Yaxis.layer.zPosition=1000
        self.addSubview(Xaxis)
        self.addSubview(Yaxis)
        
        
        //get touches
        touchView = TouchView(frame: dimensions.curveSize)
        touchView.delegate=self
        touchView.isUserInteractionEnabled=true
        self.addSubview(touchView)
        
        
        //marker
        marker = CurveMarker(frame: dimensions.markerFrame)
        touchView.addSubview(marker)
        
        
        //bubble
        
        bubbleView=GraphBubble(frame: dimensions.bubbleFrame,font:"LucidaGrande")
        bubbleView.delegate=self
        self.addSubview(bubbleView)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //**** delegates
    
    
    //touch moved delegate - move marker
    func TouchViewDelegate(touched: CGPoint) {
        
        //show marker
        marker.isHidden=false
        bubbleView.hide()
        
        
        let movingPoint = geometric.getPointOnPath(touch: touched)
        var finalPoint:CGPoint =  movingPoint.pointOnScreen
        let isOnGraph = movingPoint.isPointOnCurve
        let value = movingPoint.value
        let date = movingPoint.date
        
        finalPoint.y=dimensions.curveSize.height-finalPoint.y
        
        //set marker
        marker.center=finalPoint
        marker.unmark()
        
        if(isOnGraph)
        {
            marker.mark()
            curveTitles.subtitle.textColor=UIColor.red
        }
        else
        {
            marker.unmark()
            curveTitles.subtitle.textColor=UIColor.black
        }
        
        
        let datefilter = DatesFilter()
        let stringDate = datefilter.getDateAsString(forDate: date, resolution: resolutions.currentXResolution)
        curveTitles.subtitle.text = String(format: "%.2f, at %@", value,stringDate)
        

        
    }
    
    
    
    //tap delegate - bring to front
    func TouchViewDelegateTap() {
        
        let numGraphs=graphs.getGraphsCount()
        var orderToGet=viewOnTop+1
        
        
        if( orderToGet==numGraphs ){orderToGet=0}
        
        //find next view to bring to front
        //view.order is constant,"viewOnTop" changes to indicate who is showing
        
        for graph in graphs.graphs
        {
          
            let name = graph.name
            let color = graph.fillColor
            let view = graph.view as! Graph
            
            
            
               if(view.order==orderToGet){
                    //bring to front
                    self.bringGraphToFront(name: name)
                    //show bubble
                    bubbleView.show(name: name, color: color)
                    //remove text
                    curveTitles.subtitle.text=""
            }
        }
        
        
    }
    
    
    
    //touch begin end delegate
    func TouchViewDelegateBeginEnd(state: String) {
        if(state=="begin"){}
        else{
            marker.isHidden=true
            curveTitles.subtitle.text=""
        }
    }
    
    
    
    //bubble delegate
    func GraphBubbleView(name: String) {
        print(name)
    }

    
    
    
    func ResolutionMenuDelegate(selected: String) {
        
        let resolutionMenuTitles = resolutions.resolutionMenuTitles
        
        //10M
        if (selected == resolutionMenuTitles[0]) { resolutions.currentXResolution=24}
            //1H
        else if (selected == resolutionMenuTitles[1]) {resolutions.currentXResolution=60}
            //1D
        else if (selected == resolutionMenuTitles[2]) {resolutions.currentXResolution=60*24}
            //3D
        else if (selected == resolutionMenuTitles[3]) {resolutions.currentXResolution=60*24*3}
            //5D
        else if (selected == resolutionMenuTitles[4]) {resolutions.currentXResolution=60*24*5}
            //1M
        else if (selected == resolutionMenuTitles[5]) {resolutions.currentXResolution=60*24*31}
        
        //new resolution
        geometric.Gresolution=resolutions.currentXResolution
        //update date to draw curve related to the right date
        geometric.endDate=Date()
        
        //update x axis
        Xaxis.updateXaxis(xAxis: geometric.getDatesLocationsPairs())
        
        
        updateCurves()
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //************ curve
    
    
    
    func updateCurves()
    {
        for graph in graphs.graphs{
            
        
            let view = graph.view as! Graph
            let viewOrder=view.order
            let data = graph.data
            let name = graph.name
            let animation=graph.animation
            let fill = view.curveFillColor
            let line = view.curveLineColor
            
            //views array
            
            //remove view
            view.removeFromSuperview()
            //add new view
            let newGraph = addCurveView(data:data, fill: fill!, line: line!, animation:animation )
            //bring back order number to graph
            newGraph.order=viewOrder
            //update graphs array
            graphs.updateView(forGraphName: name, view: newGraph)
            //update z's
            bringGraphToFront(name: name)
            
        }
        
    }
    
    
    
    //add new from outside only
    func addNewCurve(name:String, data:[[String:Any]],fillColor:UIColor,lineColor:UIColor, animation:String)
    {
        
        
        
        //add curve
        let newGraphView=addCurveView(data:data, fill: fillColor, line: lineColor,animation:animation )
        newGraphView.order=graphs.getGraphsCount()
        
        
        //add new curve to array
        graphs.addGraph(name: name, data: data, view: newGraphView, fill: fillColor, line: lineColor, animation: animation)
        
        
        bringGraphToFront(name: name)
        
        //update y axis , maximum value and curve locations will only be calculated according to first graph's data
        Yaxis.updateYaxis(yAxis: geometric.getYAxisPairs())
        
        
        
        
        
        
        
    }
    
    
    //add actual view from inside only
    private func addCurveView(data:[[String:Any]],fill:UIColor, line:UIColor,animation:String)->Graph
    {
        
        
        geometric.dataPairs=data
 
        //add curve
        let graph = Graph(frame: dimensions.curveSize,points:geometric.getCurvePairsInPixels())
        graph.curveFillColor=fill
        graph.curveLineColor=line
        self.addSubview(graph)
 
        graph.startDrawingCurve(duration: 1.0, animation:animation )
        
        return graph
        
    }
    
    
    func bringGraphToFront(name:String)
    {
        
    
                let view:Graph = graphs.getGraphView(withName: name) as! Graph
                let data = graphs.getGraphData(withName: name)
            
 
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
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }


}
