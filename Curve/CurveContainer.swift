//
//  CurveContainer.swift
//  Papaya
//
//  Created by ran T on 07/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveContainer: UIView,ResolutionMenuProtocol,TouchViewProtocol,GraphBubbleViewProtocol,XAxisProtocol  {

    
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
    
    private var currentGraphsOffset:CGFloat=0
    
    
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        

        //set dimensions and resolutions structures - to live forever
        
        dimensions = CurveDimensions(frame: frame)        
        resolutions=CurveResolutions.init(maxXAxisValues: 6, currentXResolution: 24, currentYResolution: 0, resolutionMenuTitles: ["10M","1H","1D","3D","5D","1M","MAX"], scrollingScreens: 2)
        
        
        //set geometrics constant vars, geometric is alive forever
        let scrollingContentSize=dimensions.frame.width*CGFloat(resolutions.scrollingScreens)
        geometric.Gsize=CGSize(width: scrollingContentSize, height: dimensions.graphHeight)
        geometric.Gresolution=resolutions.currentXResolution*resolutions.scrollingScreens //1screen resolution x num screens
        geometric.GmaxValue=CGFloat(resolutions.currentYResolution)
        geometric.GmaxXAxisValues=resolutions.maxXAxisValues
        geometric.numScreensToScroll=resolutions.scrollingScreens
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
        
        let axisLabelColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
        Xaxis = XAxis(frame: dimensions.axisXFrame, textColor: axisLabelColor, font:"LucidaGrande",scrollerContentWidth:dimensions.frame.width*CGFloat(resolutions.scrollingScreens))
        Xaxis.backgroundColor=UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        Xaxis.delegate=self //delegate before update to let scrolling update this view for offset calculations
        Xaxis.updateXaxis(xAxis: getStringDatesLocationsPairs(pairs: geometric.getDatesLocationsPairs()) )
        
        
        
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
        
        
        //menu
        
        let menuB = MenuButton(frame: dimensions.menuBFrame)
        self.addSubview(menuB)

    }
    
    
    
    
    //dates manipulations
    
    
    func getStringDatesLocationsPairs(pairs:[[Date:CGFloat]])->[[String:CGFloat]]
    {
        var final = [[String:CGFloat]]()
        
      
        for element in pairs{
            let value = Array(element.values)[0]
            let date = Array(element.keys)[0]
            let dateString = getStringForDate(date: date)
            final.append([dateString:value])
        }
        return final
    }
    
    func getStringForDate(date:Date)->String
    {
        //get date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat=resolutions.getDateStringFormat()
        return  dateFormatter.string(from: date)
        
    }
    
    
    
    
    
    
    
    
    //**** delegates
    
 
    
    //scrolling the x delegate
    func XAxisDelegate(offset: CGFloat) {
 
        
        currentGraphsOffset=offset
         
 
        for graph in graphs.graphs
        {
            
            let view = graph.view as! Graph
            let frm=view.scroller.frame
            view.scroller.scrollRectToVisible(CGRect(x: offset, y: 0, width: frm.width, height: frm.height), animated: false)
        }
    }
    
    
    //touch moved delegate - move marker
    func TouchViewDelegate(touched: CGPoint) {
        
      
        //show marker
        marker.isHidden=false
        bubbleView.hide()
        
        //touch point referenced to scrolling position of graphs (touch is single screen)
        let touchPointReferenced = CGPoint(x: touched.x+currentGraphsOffset, y: touched.y)
        
        let movingPoint = geometric.getPointOnPath(touch: touchPointReferenced)
        var finalPoint:CGPoint =  movingPoint.pointOnScreen
        let isOnGraph = movingPoint.isPointOnCurve
        let value = movingPoint.value
        let date = movingPoint.date
        finalPoint.y=dimensions.curveSize.height-finalPoint.y
        finalPoint.x=finalPoint.x-currentGraphsOffset
        
      
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
        
        
        curveTitles.subtitle.text = String(format: "%.2f, at %@", value,getStringForDate(date: date))
        

        
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
        
 
        //update resolution
        resolutions.setResolutionForString(selection: selected)
 
        
        //update geometric resolution
        geometric.Gresolution=resolutions.currentXResolution*resolutions.scrollingScreens
        //update date to draw curve related to the right date
        geometric.endDate=Date()
        
        //update x axis
        Xaxis.updateXaxis(xAxis: getStringDatesLocationsPairs(pairs: geometric.getDatesLocationsPairs()))
        
        
        
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
        
        //check if has higher max, if has, update max, then first update previous to current max, then draw new
        if (geometric.isHigherMax(Newdata: data)) {updateCurves()}
        
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
        let graph = Graph(frame: dimensions.curveSize,points:geometric.getCurvePairsInPixels(scrollingScreens: resolutions.scrollingScreens),scrollerContentWidth:dimensions.frame.width*CGFloat(resolutions.scrollingScreens))
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
                geometric.CurvePairsInPixels = geometric.getCurvePairsInPixels(scrollingScreens: resolutions.scrollingScreens)
                return
        
   
        
        
    }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }


}
