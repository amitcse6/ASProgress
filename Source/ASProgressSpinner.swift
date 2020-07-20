//
//  ASProgressSpinner.swift
//  superapp
//
//  Created by Amit on 20/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation
import UIKit

public class ASProgressSpinner: UIView {
    public override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }
    
    public override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.fillColor = nil
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 3
        setPath()
    }
    
    public override func didMoveToWindow() {
        animate()
    }
    
    private func setPath() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2.0, dy: layer.lineWidth / 2.0)).cgPath
    }
    
    struct ASPPos {
        let secondsPriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsPriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsPriorPose = secondsPriorPose
            self.start = start
            self.length = length
        }
    }
    
    class var aspposes: [ASPPos] {
        get {
            return [
                ASPPos(0.0, 0.000, 0.7),
                ASPPos(0.6, 0.500, 0.5),
                ASPPos(0.6, 1.000, 0.3),
                ASPPos(0.6, 1.500, 0.1),
                ASPPos(0.2, 1.875, 0.1),
                ASPPos(0.2, 2.250, 0.3),
                ASPPos(0.2, 2.625, 0.5),
                ASPPos(0.2, 3.000, 0.7),
            ]
        }
    }
    
    func animate() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()
        
        let poses = type(of: self).aspposes
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsPriorPose }
        
        for pose in poses {
            time += pose.secondsPriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }
        
        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])
        
        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
        animateStrokeHueWithDuration(duration: totalSeconds * 5)
    }
    
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        //animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
    
    func animateStrokeHueWithDuration(duration: CFTimeInterval) {
        let count = 20
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.keyTimes = (0 ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
        animation.values = (0 ... count).map {
            UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        animation.duration = duration
        //animation.calculationMode = .linear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}
