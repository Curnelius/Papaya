//
//  CurrentGraphsList.swift
//  Papaya
//
//  Created by ran T on 08/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit

class CurrentGraphsList: NSObject {
    
    
    
    
    struct Graph {
        var view:UIView
        var name:String
        var fillColor:UIColor
        var lineColor:UIColor
        var data:[[String:Any]]
        var animation:String
    }
    
    
    var graphs = [Graph]()

    
    
    
    func addGraph(name:String,data:[[String:Any]], view:UIView, fill: UIColor, line: UIColor,animation:String)
    {
      
        let newGraph = Graph(view: view, name: name, fillColor: fill, lineColor:line, data: data, animation: animation)
        graphs.append(newGraph)
        
    }
    
    func getGraphsCount()->Int
    {
        return graphs.count
    }
    
    
    func getGraphView(withName:String)->UIView
    {
        //for i in 0..<self.getGraphsCount()
        
            for graph in graphs {
                
       
                let view = graph.view
                let graphName = graph.name
                
                    if(graphName==withName)
                    {
                        return view
                    }
             }
         return UIView(frame: .zero)
    }
    
    
    func getGraphData(withName:String)->[[String:Any]]
    {
        for graph in graphs{
            
 
            let graphName = graph.name
            let data = graph.data 
            
            if(graphName==withName)
            {
                return data
            }
        }
        return [["error":"error"]]
    }
    
    
    func updateView(forGraphName:String, view:UIView)
    {
        
        for i in 0..<self.getGraphsCount(){
 
                var  graph = graphs[i] as Graph
                if(graph.name==forGraphName)
                {
                    graph.view=view
                    graphs[i]=graph
                }
        }
    }

    
    
    
}
