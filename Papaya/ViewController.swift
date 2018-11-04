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
        var data2 = [[String:Any]]()
        let dateCount=90
        
        for i in 0..<dateCount
        {
            //date
            let current = Date()
            let date = current.addingTimeInterval(Double(-2 * (dateCount-i)) * 60.0)
            
            //value
            let random:CGFloat =  1.0+CGFloat(arc4random()%100)//   CGFloat(  Double(sin(sinus)) * Double.pi / 180   ) //1.0+CGFloat(arc4random()%20)
 
            
           //avv
         
            var av:CGFloat = 0
            var count:CGFloat=1
            for pair in data.reversed()
            {
                let value:CGFloat=pair["value"] as! CGFloat
                av=av+value
                count+=1
                if (count==20){break}
              
            
            }
            av=av/count
 
 
            
            //add
            var pair1 =  [String:Any]()
            pair1["date"]=date
            pair1["value"]=random
            data.append(pair1)
            
            var pair2 =  [String:Any]()
            pair2["date"]=date
            pair2["value"]=av
            data2.append(pair2)
        
        }

        
  
 
        //add curve view (not curve)
        let size = CGRect(x: 10, y: 50, width: w, height: h)
        let curve = Curve(frame: size)
        curve.curveTitles.setTitles(titleName: "Garden Sensor", subtitleName: "Under The Garden Tree")
        curve.curveTitles.setFonts(titleFont: "LucidaGrande-Bold", subtitleFont: "LucidaGrande", titleSize: 22, subtitleSize: 11)
        self.view.addSubview(curve)

        curve.addCurve(name: "main", data: data, fillColor:UIColor(red: 253.0/255.0, green:173.0/255.0, blue:76.0/255.0, alpha: 1.0),lineColor:UIColor(red: 253.0/255.0, green:173.0/255.0, blue:76.0/255.0, alpha: 1.0),animation:"bottom" )
 

 
        curve.addCurve(name: "main", data: data2, fillColor:UIColor.clear,lineColor:UIColor(red: 0.99, green: 0.0, blue: 0.2, alpha: 1.0),animation:"left"   )
        
  
        
print(data)
 
        
        
     }


}


 
