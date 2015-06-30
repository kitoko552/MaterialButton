//
//  MaterialButton.swift
//  MaterialButton
//
//  Created by Kosuke Kito on 2015/06/29.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {
  private static let ExtraTouchableDistance: CGFloat = 70.0
  private static let DelayAfterAnimation: CFTimeInterval = 0.06
  
  private var expands = false
  private let rippleLayer = CALayer()
    
  var expandDuration: CFTimeInterval = 0.08
  var contractDuration: CFTimeInterval = 0.1
  
  var rippleOpacity: Float = 0.2 {
    willSet {
      rippleLayer.opacity = newValue
    }
  }
    
  var rippleColor = UIColor.whiteColor() {
    willSet {
      rippleLayer.backgroundColor = newValue.CGColor
    }
  }
  
    
  // MARK: - Initializer
  
  convenience init() {
    self.init(frame: CGRectZero)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addRippleLayer()
  }
    
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addRippleLayer()
  }
    
  private func addRippleLayer() {
    rippleLayer.frame = self.bounds
    rippleLayer.backgroundColor = rippleColor.CGColor
    rippleLayer.opacity = rippleOpacity
    rippleLayer.mask = CAShapeLayer()
    self.layer.addSublayer(rippleLayer)
  }
    
    
  // MARK: - Touches Events
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch = touches.first as! UITouch
    let touchPoint = touch.locationInView(self)
    
    expands = true
        
    expandAnimation(touchPoint)
  }
    
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch = touches.first as! UITouch
    let touchPoint = touch.locationInView(self)
            
    if acceptable(touchPoint) {
      if !expands {
        expands = true
        expandAnimation(touchPoint)
      }
    } else {
      if expands {
        expands = false
        contractAnimation(touchPoint)
      }
    }
  }
    
  override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
    let touch = touches.first as! UITouch
    let touchPoint = touch.locationInView(self)
    
    sendActionsForControlEvents(.TouchCancel)
    contractAnimation(touchPoint)
  }
    
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    let touch = touches.first as! UITouch
    let touchPoint = touch.locationInView(self)
        
    if acceptable(touchPoint) {
      // send actions after animation has completed.
      NSThread.sleepForTimeInterval(expandDuration + MaterialButton.DelayAfterAnimation)
      sendActionsForControlEvents(.TouchUpInside)
      contractAnimation(touchPoint)
    } else {
      sendActionsForControlEvents(.TouchUpOutside)
    }
  }
    
  private func acceptable(touchPoint: CGPoint) -> Bool {
    return (touchPoint.x < self.bounds.size.width + MaterialButton.ExtraTouchableDistance)
      && (touchPoint.x > -MaterialButton.ExtraTouchableDistance)
      && (touchPoint.y < self.bounds.size.height + MaterialButton.ExtraTouchableDistance)
      && (touchPoint.y > -MaterialButton.ExtraTouchableDistance)
  }
    
    
  // MARK: - Animation
    
  private func expandAnimation(touchPoint: CGPoint) {
    let initialPath = CGPathCreateWithEllipseInRect(CGRectMake(touchPoint.x, touchPoint.y, 0, 0), nil)
    let expandedPath = CGPathCreateWithEllipseInRect(self.bounds, nil)
    
    let rippleAnimation = setupAnimation(duration: expandDuration, fromValue: initialPath, toValue: expandedPath)
    rippleLayer.mask.addAnimation(rippleAnimation, forKey: nil)
  }
    
  private func contractAnimation(touchPoint: CGPoint) {
    let initialPath = CGPathCreateWithEllipseInRect(self.bounds, nil)
    let expandedPath = CGPathCreateWithEllipseInRect(CGRectMake(touchPoint.x, touchPoint.y, 0, 0), nil)
    
    let rippleAnimation = setupAnimation(duration: contractDuration, fromValue: initialPath, toValue: expandedPath)
    rippleLayer.mask.addAnimation(rippleAnimation, forKey: nil)
  }
  
  private func setupAnimation(#duration: CFTimeInterval, fromValue: CGPath, toValue: CGPath) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "path")
    animation.duration = duration
    animation.fromValue = fromValue
    animation.toValue = toValue
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    
    return animation
  }
  
}
