//
//  GraphBubble.swift
//  Papaya
//
//  Created by ran T on 07/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit




protocol GraphBubbleViewProtocol : class {
    
    func GraphBubbleView(name:String )
 
    
}




class GraphBubble: UIView {

    var bubble:UIButton!
    var showing:Bool = false
    var delegate:GraphBubbleViewProtocol! = nil

    
    
    
    init (frame : CGRect, font:String)
    {
        
        super.init(frame : frame)
        
        bubble = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        bubble.layer.cornerRadius=frame.size.height/2.0
        bubble.titleLabel?.font=UIFont(name: font, size: 10)
        bubble.setTitleColor(UIColor.black, for: .normal)
        bubble.addTarget(self, action:#selector(self.pressed), for: .touchUpInside)



        
        
        //shadow
        bubble.layer.shadowColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        bubble.layer.shadowOffset=CGSize(width: 2.0, height: 2.0)
        bubble.layer.shadowRadius=2.0
        bubble.layer.shadowOpacity=0.75
        
        
 
        
        
    }
    
    
    func show(name:String, color:UIColor)
    {
        
        if(showing){
            bubble.backgroundColor=color
            bubble.setTitle(name, for: .normal)
            return
        }
        
        showing=true
        
        let frm=bubble.frame
        bubble.backgroundColor=color
        bubble.setTitle(name, for: .normal)
        self.addSubview(bubble)
        bubble.alpha=0.8
        bubble.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.2, animations: {
            self.bubble.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.bubble.layer.cornerRadius=frm.size.height/2.0
            self.bubble.alpha=1.0
        },  completion: { _ in
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              
                //remove slowly
                UIView.animate(withDuration: 0.2, animations: {
                    self.bubble.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    self.bubble.layer.cornerRadius=frm.size.height/2.0
                },  completion: { _ in
                    //back to normal and remove
                    self.bubble.transform =  CGAffineTransform.identity
                    self.bubble.removeFromSuperview()
                    self.showing=false
                })
                //
                
            }
            

        })
        
        
        
 
        
    }
    
    
    func hide()
    {
        bubble.removeFromSuperview()
    }
    
    
  
    
    @objc func pressed(sender:UIButton)
    {
        self.delegate.GraphBubbleView(name: (sender.titleLabel?.text)!)
    }
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder)
    }

    

}






 
