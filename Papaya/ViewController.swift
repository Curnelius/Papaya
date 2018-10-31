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
        let h:CGFloat=0.8*w
        
        
        
        
       //fake data
 
        let current = Date()
        let date1 = current.addingTimeInterval(-0 * 60.0)
        let date2 = current.addingTimeInterval(-1 * 60.0)
        let date3 = current.addingTimeInterval(-2 * 60.0)
        let date4 = current.addingTimeInterval(-3 * 60.0)
        let date5 = current.addingTimeInterval(-4 * 60.0)
        let date6 = current.addingTimeInterval(-5 * 60.0)
        let date7 = current.addingTimeInterval(-6 * 60.0)
        let date8 = current.addingTimeInterval(-7 * 60.0)
        let date9 = current.addingTimeInterval(-8 * 60.0)
        let date10 = current.addingTimeInterval(-9 * 60.0)
        let datesArray = [date10,date9,date8,date7,date6,date5,date4,date3,date2,date1]
        
        var pointsArray = [CGFloat]()
        pointsArray.append(contentsOf: [12.0,10.0,2.0,8.0,5.0,2.0,4.0,3.0,8.0,3.0])
     
        
        var pointsArray2 = [CGFloat]()
        pointsArray2.append(contentsOf: [6.0,80.0,12.0,10.0,5.0,14.0,12.0,10.0,5.0,3.0])
        
        
        
        //dictionary
        var data = [[String:Any]]()
        for index in 0..<datesArray.count
        {
            var pair =  [String:Any]()
            pair["date"]=datesArray[index]
            pair["value"]=pointsArray[index]
            data.append(pair)
        }
        
        
        var data2 = [[String:Any]]()
        for index in 0..<datesArray.count
        {
            var pair =  [String:Any]()
            pair["date"]=datesArray[index]
            pair["value"]=pointsArray2[index]
            data2.append(pair)
        }
        
        
 

        //add curve
        let size = CGRect(x: 10, y: 25, width: w, height: h)
        let curve = Curve(frame: size)
        curve.curveTitles.setTitles(titleName: "Sensor Garden", subtitleName: "Under the garden tree")
        curve.curveTitles.setFonts(titleFont: "LucidaGrande-Bold", subtitleFont: "LucidaGrande", titleSize: 22, subtitleSize: 11)
        self.view.addSubview(curve)

        curve.addCurve(name: "main", data: data, resolutionInMin: 9, Yresolution: 0, fillColor:UIColor.yellow,lineColor:UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.5)  )
        curve.addCurve(name: "second", data: data2, resolutionInMin: 9, Yresolution: 0, fillColor:UIColor.clear,lineColor:UIColor.black)


     
 
        
        

 
        
        
     }


}


 
