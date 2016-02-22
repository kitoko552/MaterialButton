//
//  MaterialButton.swift
//  MaterialButton
//
//  Created by Kosuke Kito on 2015/06/29.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {
    private var expands = false
    private let rippleLayer = CALayer()
    
    var expandDuration: CFTimeInterval = 0.1
    var contractDuration: CFTimeInterval = 0.2
    var fadeDuration: CFTimeInterval = 0.5
    
    var rippleOpacity: Float = 0.2 {
        didSet {
            rippleLayer.opacity = rippleOpacity
        }
    }
    
    var rippleColor = UIColor.whiteColor() {
        didSet {
            rippleLayer.backgroundColor = rippleColor.CGColor
        }
    }

    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRippleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addRippleLayer()
    }
}
    
    
// MARK: - Touches Events
extension MaterialButton {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPoint = touch.locationInView(self)
        expands = true
        expandAnimation(touchPoint)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
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
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touch = touches?.first else {
            return
        }
        
        let touchPoint = touch.locationInView(self)
        sendActionsForControlEvents(.TouchCancel)
        contractAnimation(touchPoint)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPoint = touch.locationInView(self)
        let delayAfterAnimation: CFTimeInterval = 0.06
        
        if acceptable(touchPoint) {
            // Send actions after animation has completed.
            NSThread.sleepForTimeInterval(expandDuration + delayAfterAnimation)
            sendActionsForControlEvents(.TouchUpInside)
            fadeAnimation()
        } else {
            sendActionsForControlEvents(.TouchUpOutside)
        }
    }
}

// MARK: - Animation
extension MaterialButton {
    private func expandAnimation(touchPoint: CGPoint) {
        rippleLayer.removeAnimationForKey("fade")
        
        let initialPath = CGPathCreateWithEllipseInRect(CGRectMake(touchPoint.x, touchPoint.y, 0, 0), nil)
        let expandedPath = CGPathCreateWithEllipseInRect(bounds, nil)
        
        let rippleAnimation = setupAnimation(keyPath: "path", duration: expandDuration, fromValue: initialPath, toValue: expandedPath)
        rippleLayer.mask?.addAnimation(rippleAnimation, forKey: nil)
    }
    
    private func contractAnimation(touchPoint: CGPoint) {
        let initialPath = CGPathCreateWithEllipseInRect(bounds, nil)
        let expandedPath = CGPathCreateWithEllipseInRect(CGRectMake(touchPoint.x, touchPoint.y, 0, 0), nil)
        
        let rippleAnimation = setupAnimation(keyPath: "path", duration: contractDuration, fromValue: initialPath, toValue: expandedPath)
        rippleLayer.mask?.addAnimation(rippleAnimation, forKey: nil)
    }
    
    private func fadeAnimation() {
        let fromValue: Float = rippleOpacity
        let toValue: Float = 0.0
        
        let rippleAnimation = setupAnimation(keyPath: "opacity", duration: fadeDuration, fromValue: fromValue, toValue: toValue)
        
        rippleLayer.addAnimation(rippleAnimation, forKey: "fade")
    }
    
    private func setupAnimation(keyPath keyPath: String, duration: CFTimeInterval, fromValue: AnyObject, toValue: AnyObject) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        return animation
    }
}

extension MaterialButton {
    private func addRippleLayer() {
        rippleLayer.frame = bounds
        rippleLayer.backgroundColor = rippleColor.CGColor
        rippleLayer.opacity = rippleOpacity
        rippleLayer.mask = CAShapeLayer()
        layer.addSublayer(rippleLayer)
    }
    
    private func acceptable(touchPoint: CGPoint) -> Bool {
        let extraTouchableDistance: CGFloat = 70.0
        
        return (touchPoint.x < bounds.size.width + extraTouchableDistance)
            && (touchPoint.x > -extraTouchableDistance)
            && (touchPoint.y < bounds.size.height + extraTouchableDistance)
            && (touchPoint.y > -extraTouchableDistance)
    }
}
