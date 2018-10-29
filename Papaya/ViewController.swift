//
//  ViewController.swift
//  Papaya
//
//  Created by ran T on 28/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        
        let w:CGFloat=0.95*view.frame.width
        let h:CGFloat=w
        
        
        //add curve
        let size = CGRect(x: 10, y: 25, width: w, height: h)
        let curve = Curve(frame: size)
        curve.curveTitles.setTitles(titleName: "Sensor Garden", subtitleName: "Under the garden tree")
        curve.curveTitles.setFonts(titleFont: "LucidaGrande-Bold", subtitleFont: "LucidaGrande", titleSize: 22, subtitleSize: 11)
        self.view.addSubview(curve)

        //curve.addGraph(name: "sensor", points: [[0,0],[1,3],[2,5],[3,6],[5,5],[6,12]], lineColor: .black, fillColor: .red)
        
        
        
        
      //fake dates
 
        let current = Date()
        let date1 = current.addingTimeInterval(-0 * 60.0)
        let date2 = current.addingTimeInterval(-1 * 60.0)
        let date3 = current.addingTimeInterval(-2 * 60.0)
        let date4 = current.addingTimeInterval(-3 * 60.0)
        let date5 = current.addingTimeInterval(-4 * 60.0)
        let date6 = current.addingTimeInterval(-5 * 60.0)
        let datesArray = [date6,date5,date4,date3,date2,date1]
        
        var pointsArray = [CGFloat]()
        pointsArray.append(contentsOf: [0.0,1.0,2.0,3.0,4.0,5.0])
 
     
 
 
        //filter dates for scale
         let geometric = Geometric()
         geometric.initWith(dates: datesArray, points: pointsArray, size: size.size)
        
        
         
        let xValues=geometric.getXValues(resolutionMin: 5)
        let yValues=geometric.getYValues()
        
        
        print(xValues)
        print(yValues)
        
 
 
   
    
        
     }


}

