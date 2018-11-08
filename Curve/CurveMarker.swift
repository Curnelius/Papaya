//
//  CurveMarker.swift
//  Papaya
//
//  Created by ran T on 04/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit

class CurveMarker: UIView {

    var marker:UIView!
    var markFrame:CGRect!
    
    
    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
        markFrame=CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        marker = UIView(frame:markFrame  )
        marker.layer.cornerRadius=frame.width/2.0
        marker.backgroundColor=UIColor.black
        marker.layer.borderColor=UIColor.white.cgColor
        marker.layer.borderWidth=1.5
        self.addSubview(marker)
    }
    
    
    
    func mark()
    {
        var frm:CGRect = markFrame as CGRect
        frm.size.width = frm.size.width*1.25
        frm.size.height = frm.size.height*1.25
        marker.frame=frm
        marker.layer.cornerRadius=frm.size.width/2.0
        marker.center=CGPoint(x: markFrame.midX, y: markFrame.midY)
        marker.backgroundColor=UIColor.red
    }
    

    func unmark()
    {
        marker.frame=markFrame
        marker.layer.borderColor=UIColor.white.cgColor
        marker.backgroundColor=UIColor.black
    }
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
