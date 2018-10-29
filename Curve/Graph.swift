//
//  Graph.swift
//  Papaya
//
//  Created by ran T on 29/10/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class Graph: UIView {

    
    var lineColor:UIColor?
    var fillColor:UIColor?
    var size:CGSize?
    
    init(lineColor: UIColor, fillColor: UIColor,size:CGSize) {
        self.lineColor = lineColor
        self.fillColor = fillColor
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    func DrawGraph()
    {
    
    }
    
    func updateGraph()
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
