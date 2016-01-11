//
//  ViewController.swift
//  PetThePet
//
//  Created by June Kim on 2016-01-10.
//  Copyright © 2016 June Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let kMaxRadius: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }
    
    override func viewDidAppear(animated: Bool) {
        checkForForceTouch()
    }
    
    func checkForForceTouch() {
        if traitCollection.forceTouchCapability != UIForceTouchCapability.Available {
            
            let alert = UIAlertController(
                title: "Unavailable",
                message: "Force touch is not available on this device.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Cancel,
                handler: { (action) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
            })
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion:nil)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.showTouches(touches)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.showTouches(touches)
    }
    
    private func showTouches(touches: Set<UITouch>) {
        for obj: AnyObject in touches {
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let radius = kMaxRadius * touch.force / touch.maximumPossibleForce
            self.createHaloAt(location, withRadius: radius)
//            print(obj)
        }
    }
    
    private func createHaloAt(location: CGPoint, withRadius radius: CGFloat) {
        let halo = PulsingHaloLayer()
        halo.repeatCount = 1
        halo.backgroundColor = UIColor.pinkColor().CGColor;
        halo.position = location
        halo.radius = radius * 1.5
        halo.fromValueForRadius = 0.5
        halo.keyTimeForHalfOpacity = 0.7
        halo.animationDuration = 0.8
        self.view.layer.addSublayer(halo)
    }

}

extension UIColor { 
   class func pinkColor() -> UIColor {
        return UIColor(red: 255/255.0, green: 192/255.0, blue: 203/255.0, alpha: 1)
    }
    
    class func colorWithRGB(rgbValue : UInt, alpha : CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    func lighterColor(percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 + percent));
    }
    
    func darkerColor(percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 - percent));
    }
    func colorWithBrightnessFactor(factor: CGFloat) -> UIColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return self;
        }
    }
}

