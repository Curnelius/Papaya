//
//  TouchView.swift
//  Papaya
//
//  Created by ran T on 05/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit




protocol TouchViewProtocol : class {
    
    func TouchViewDelegate(touched:CGPoint )
    func TouchViewDelegateTap()
    func TouchViewDelegateBeginEnd(state:String)
    
}




class TouchView: UIView {
    
    
    var delegate:TouchViewProtocol! = nil

    

    override init (frame : CGRect)
    {
        
        super.init(frame : frame)
        
        self.backgroundColor=UIColor.clear
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        self.addGestureRecognizer(tapRecognizer)
       // tapRecognizer.delegate = self as! UIGestureRecognizerDelegate

    }
    
    
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
       self.delegate.TouchViewDelegateTap()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.TouchViewDelegateBeginEnd(state: "begin")
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        
        if let theTouch = touches.first {
            let thisPoint = theTouch.location(in: self)
            let lastPoint = theTouch.previousLocation(in: self)
            self.delegate.TouchViewDelegate(touched: thisPoint)

        }
    }
    
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.TouchViewDelegateBeginEnd(state: "ended")
    }
    
    
    
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
