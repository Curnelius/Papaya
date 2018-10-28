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
        let h:CGFloat=0.39*view.frame.height
        
        //add curve
        let size = CGRect(x: 10, y: 200, width: w, height: h)
        let curve = Curve(frame: size)
        curve.curveTitles.title.text="Rani"
        curve.curveTitles.subtitle.text="In The Graph"
        self.view.addSubview(curve)
        
        
        
        
     }


}

