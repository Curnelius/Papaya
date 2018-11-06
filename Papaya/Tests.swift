//
//  File.swift
//  Papaya
//
//  Created by ran T on 05/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit

class Tests {


    
    func getSingleSetOfData(intervals:Int, numberElements:Int, max:Int)->[[String:Any]]
    {
        
        //fake data
        var data = [[String:Any]]()
        let dateCount=numberElements
        
        for i in 0..<dateCount
        {
            //date
            let current = Date()
            let date = current.addingTimeInterval(Double(-intervals * (dateCount-i)) * 60.0)
            
            //value
            let random:CGFloat =  0+CGFloat(arc4random()%UInt32(max))//   CGFloat(  Double(sin(sinus)) * Double.pi / 180   ) //1.0+CGFloat(arc4random()%20)
            
            
 
            //add
            var pair1 =  [String:Any]()
            pair1["date"]=date
            pair1["value"]=random
            data.append(pair1)
            
         
        }
        print(data.last)
        return data

    }
    
    
    
    
    func getAverageForData(data:[[String:Any]],parameter:Int)->[[String:Any]]
    {
        var rdata = [[String:Any]]()

        for i in 0..<data.count
        {
            
            
            var av:CGFloat = 0
            var count:CGFloat=1
            let to = max(0, i-parameter)
            for index in stride(from: i, to: to, by: -1)
            
            {
                if(i<0){break}
                let pair = data[index]
                let value:CGFloat=pair["value"] as! CGFloat
                av=av+value
                
                count+=1
                if (Int(count)==parameter){break}
                
            }
            av=av/count
 
            var pair2 =  [String:Any]()
            pair2["date"]=data[i]["date"]
            pair2["value"]=av
            rdata.append(pair2)
           

            
        }
        
       return rdata
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



}
