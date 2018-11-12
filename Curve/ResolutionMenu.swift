//
//  ResolutionMenu.swift
//  Papaya
//
//  Created by ran T on 03/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import UIKit



protocol ResolutionMenuProtocol : class {
    
    func ResolutionMenuDelegate(selected:String )
    
}



class ResolutionMenu: UIView {

    
    var labelColor:UIColor = UIColor.gray
    var defaultFont = "Avenir-Light"
    var titlelist = [String]()
    var tselection = 0
    var selected:UIView!
    var selectedIndex = 0
    
    var delegate:ResolutionMenuProtocol! = nil

    
    
    init (frame : CGRect, textColor:UIColor,font:String, list:[String],selection:Int)
    {
        
        labelColor=textColor
        defaultFont=font
        tselection=selection
        titlelist=list
        super.init(frame : frame)
        self.backgroundColor=UIColor.clear
        let num = list.count
        let size = frame.size.width/CGFloat(num)
        var count:CGFloat = 0
        for string in list
        {
            
            
            let button:UIButton = UIButton(frame: CGRect(x: count*size, y:0, width: size, height: frame.height))
            button.backgroundColor = .clear
            button.setTitle(string, for: .normal)
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            button.titleLabel?.font=UIFont(name: defaultFont, size: 10)
            button.setTitleColor(labelColor, for: .normal)
            button.tag=Int(count)
            self.addSubview(button)
            count+=1
            
            
        }
        
        
        selected = UIView(frame: CGRect(x: size/4.0, y: frame.height-2.0-2.0, width: size/2.0, height: 2.0))
        selected.backgroundColor=UIColor.red
        selected.layer.cornerRadius=2.0
        self.addSubview(selected)
        
 
        
        
    }
    
    @objc func buttonClicked(id:UIButton) {
        
        selectedIndex=id.tag
        self.delegate.ResolutionMenuDelegate(selected: titlelist[selectedIndex])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.selected.frame.origin.x=id.frame.origin.x+(id.frame.width-self.selected.frame.width)/2.0

        }, completion: nil)
 
    }
    
    
    
    func setSelection(index:Int)
    {
        selectedIndex=index
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        // Need to initialize the number property here. Do so appropriately.
        super.init(coder: aDecoder) }
    


}
