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
    
 
    
    
    init (frame : CGRect,points:[CGPoint], fillColor:UIColor,lineColor:UIColor)
    {
        curveLineColor=lineColor
        curveFillColor=fillColor
        curvePoints=points
        super.init(frame : frame)
        self.backgroundColor=UIColor.clear
        size=frame.size
        
        
        //self.layer.cornerRadius = 20.0
    }
    
    
    func drawCurve()
    {
        
         let path = UIBezierPath()
         var point1:CGPoint!
         var point2:CGPoint!
     
        
         for i in 0..<curvePoints.count-1
         {
            point1 = curvePoints[i]
            point2 = curvePoints[i+1]
            
            point1.y=size!.height-point1.y
            point2.y=size!.height-point2.y
            
           
            if( i == 0 ) {path.move(to: point1)}
            
            path.addLine(to: point2)
            
            
            
  

         }
        
        //close the path
        path.addLine(to: CGPoint(x: point2.x, y: frame.height))
        path.addLine(to: CGPoint(x:curvePoints[0].x, y: frame.height))
        //path.addLine(to: firstpoint)
        //path.close()
        
     
        
        
        let shapeLayer = CAShapeLayer()
        //shapeLayer.frame=CGRect(x: 0, y: 0, width: (size?.width)!, height: size!.height)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = curveFillColor!.cgColor
        shapeLayer.strokeColor = curveLineColor!.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillRule = .evenOdd
        self.layer.addSublayer(shapeLayer)
        
    }
    
    
    
 

    
 
 
    
  
    
    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder)
    }

}
