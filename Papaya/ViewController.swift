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
        var data = [[String:Any]]()
        let dateCount=10
        
        for i in 0..<dateCount
        {
            //date
            let current = Date()
            let date = current.addingTimeInterval(Double(-1 * (dateCount-i)) * 60.0)
            
            //value
            let sinus = CGFloat(i)/10.0
            let random:CGFloat =  1.0+CGFloat(arc4random()%20)//   CGFloat(  Double(sin(sinus)) * Double.pi / 180   ) //1.0+CGFloat(arc4random()%20)
 
            
            //add
            var pair =  [String:Any]()
            pair["date"]=date
            pair["value"]=random
            data.append(pair)
        
        }

        
  
        
 
 

        //add curve view (not curve)
        let size = CGRect(x: 10, y: 50, width: w, height: h)
        let curve = Curve(frame: size)
        curve.curveTitles.setTitles(titleName: "Sensor Garden", subtitleName: "Under the garden tree")
        curve.curveTitles.setFonts(titleFont: "LucidaGrande-Bold", subtitleFont: "LucidaGrande", titleSize: 22, subtitleSize: 11)
        self.view.addSubview(curve)

        curve.addCurve(name: "main", data: data, fillColor:UIColor(red: 255.0/255.0, green:255.0/255.0, blue:100.0/255.0, alpha: 1.0),lineColor:UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.5)  )
 

 
        print(data)
       
  
        

 
        
        
     }


}


 
