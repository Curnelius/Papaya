//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
        view.backgroundColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        self.view.addSubview(view)

    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
