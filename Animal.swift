//
//  Animal.swift
//  PetThePet
//
//  Created by June Kim on 2016-01-10.
//  Copyright © 2016 June Kim. All rights reserved.
//

import UIKit

typealias Pressure = CGFloat

class Animal: NSObject { //level 1 is rabbit.

    var living = true;
    var size = 1;
    var happyThreshold :Pressure = 1.5;
    var madnessThreshold :Pressure = 1.9;
    var explodingThreshold :Pressure = 5.0;
    
    var imageView: UIImageView! = UIImageView();
    
    private var overlayView:UIView!
    var overlayColor: UIColor = UIColor.clearColor();
    
    
    
    override init() {
        super.init()
        
    }
    
    func setup() {
        //TODO: make imageview.
        imageView = UIImageView(image: UIImage(named: "rabbitImage2"))
        overlayView = UIView();
        imageView.addSubview(overlayView);
    }
    
    func move() {
        
    }
    
    func getNeutral() {
        changeColors(UIColor.yellowColor())
    }
    
    func getHappy() {
        changeColors(UIColor.greenColor())
    }
    
    func getMad() {
        changeColors(UIColor.redColor())
    }
    
    func explode() {
        living = false;
        changeColors(UIColor.blackColor())
    }
    
    func changeColors(color: UIColor) {
        overlayColor = color.colorWithAlphaComponent(0.5);
        overlayView.frame = imageView.bounds;
        overlayView.backgroundColor = overlayColor;
    }
    
    func apply(appliedPressure: Pressure) {
        print(appliedPressure)
        if (!living) {
            return;
        }
        if (appliedPressure <= happyThreshold) {
            getNeutral()
        } else if (appliedPressure <= madnessThreshold) {
            getHappy()
        } else if (appliedPressure <= explodingThreshold) {
            getMad()
        } else {
            explode()
        }

    }
    
    func updateView() {
        //TODO: double the size when dead.
        
    }
    
    
}
