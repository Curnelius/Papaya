//
//  Graph.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit


 



class Graph: UIView {

    
    var curveLineColor:UIColor?
    var curveFillColor:UIColor?
    var size:CGSize?
    var curvePoints = [CGPoint]()
    var order = 0
    private let shapeLayer = CAShapeLayer()
    
    
    private var displayLink: CADisplayLink?
    private var startTime = 0.0
    private var animLength = 1.0
 
 
    var scroller:UIScrollView!
    
    
    
    
    
    
    
    init (frame : CGRect,points:[CGPoint], scrollerContentWidth:CGFloat)
    {

        curvePoints=points
        super.init(frame : frame)
        self.backgroundColor=UIColor.clear
        size=frame.size
        
      
        
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        scroller.alwaysBounceHorizontal = true
        scroller.contentSize=CGSize(width: scrollerContentWidth, height: frame.height)
        scroller.bounces=false
        scroller.showsHorizontalScrollIndicator=false
        scroller.isScrollEnabled=false
        
        self.addSubview(scroller) 
        
        
 
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeStart = 0
        scroller.layer.addSublayer(shapeLayer)
        
        
        //put at end to be synced with the dates scroller.
        scroller.setContentOffset(CGPoint(x: scroller.contentSize.width-scroller.frame.width, y: 0), animated: false)

        
        
        
    }
    
    
    
    
    
    
    //display link
    
    
    
    func createClock() {
        
        stopDisplayLink()
        startTime = CACurrentMediaTime() // reset start time
        
        // create displayLink & add it to the run-loop
        let displayLink = CADisplayLink(
            target: self, selector: #selector(displayLinkDidFire)
        )
        displayLink.add(to: .current, forMode: .default)
                        
        self.displayLink = displayLink
    }
    

    
    @objc func displayLinkDidFire(_ displayLink: CADisplayLink) {
        
        var elapsed = CACurrentMediaTime() - startTime
        
        if elapsed > animLength {
            stopDisplayLink()
            elapsed = animLength // clamp the elapsed time to the anim length
        }
        
        drawCurve(height: CGFloat(elapsed/animLength))
       
    }
    

    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    
    
    
    
    
    
    
    
    
    
    func startDrawingCurve(duration:Float,animation:String)
    {
        
        shapeLayer.fillColor =  curveFillColor!.cgColor
        shapeLayer.strokeColor = curveLineColor!.cgColor
        
        animLength=Double(duration)
        
        if(animation == "left")
        {
            self.drawFromLeft(duration: duration)
            return
        }


        
        createClock()
    }
    
    
    
    func drawFromLeft(duration:Float)
    {
        
        //no fill
        shapeLayer.fillColor =  UIColor.clear.cgColor
        shapeLayer.lineWidth=2.0
        
        //set the path for maximum height
        drawCurve(height: 1.0)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(duration)
        shapeLayer.add(animation, forKey: "MyAnimation")
    }
    
    
    
    //draw height gradually
    func drawCurve(height:CGFloat)
    {
        
        //less than 2 points
        if (curvePoints.count<2){ return }
  
        
         let path = UIBezierPath()
         var point1:CGPoint!
         var point2:CGPoint!
         //var smoothData = self.smooth(alpha: 0.4)
        
        
 
       
       
        
        
        
        
         for i in 0..<curvePoints.count-1
         {
                point1 =  curvePoints[i]
                point2 = curvePoints[i+1]
            
               // 1. draw height slowly up 2. change drawing y - screen default start from top
                point1.y = (size!.height-height*point1.y)
                point2.y = (size!.height-height*point2.y)

          
            
            if( i == 0 ) {path.move(to: point1)}
            
            path.addLine(to: point2)

          }
        
        
        //close the path if we have a fill
        if(curveFillColor != UIColor.clear)
        {
        
              path.addLine(to: CGPoint(x: point2.x, y: frame.height))
              path.addLine(to: CGPoint(x:curvePoints[0].x, y: frame.height))
              path.addLine(to: CGPoint(x:curvePoints[0].x, y: size!.height-height*curvePoints[0].y))

        }
 
  
        shapeLayer.path = path.cgPath
      
 
 
    
    }
    
    
    
    
 
 

    func smooth(alpha:CGFloat)->[CGPoint]
    {
        
         //Y(n) = (1-ß)*Y(n-1)
        var lastPoint = CGPoint(x: 0, y: 0  )
        var smoothData = [CGPoint]()
        
        for point in curvePoints
        {

            let newY = (1-alpha)*lastPoint.y
            let newPoint = CGPoint(x: point.x, y: newY)
            smoothData.append(newPoint)
            lastPoint=point
        }
        
        return smoothData
    }
 
 
    
    
    
 
    
  
    
    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder)
    }

}
