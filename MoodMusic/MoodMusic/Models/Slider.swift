//
//  Slider.swift
//  MoodMusic
//
//  Created by Nina on 12/12/19.
//  Copyright © 2019 Vibe. All rights reserved.
//
// Created with the help of https://www.raywenderlich.com/7595-how-to-make-a-custom-control-tutorial-a-reusable-slider

import Foundation
import UIKit

public class Slider: UIControl {
  var minimumValue: CGFloat = 0
  var maximumValue: CGFloat = 1
  var lowerValue: CGFloat = 0.2
  var upperValue: CGFloat = 0.8
    private var previousLocation = CGPoint()
    
    var thumbImage = #imageLiteral(resourceName: "thumbImage")

    private let trackLayer = CALayer()
    private let pointThumbImageView = UIImageView()
    
    override public var frame: CGRect {
      didSet {
        updateLayerFrames()
      }
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      
      pointThumbImageView.image = thumbImage
      addSubview(pointThumbImageView)
      
        
    updateLayerFrames()
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // 1
    private func updateLayerFrames() {
      trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
      trackLayer.setNeedsDisplay()
      pointThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                         size: thumbImage.size)
    }
    // 2
    func positionForValue(_ value: CGFloat) -> CGFloat {
      return bounds.width * value
    }
    // 3
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
      let x = positionForValue(value) - thumbImage.size.width / 2.0
      return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
    
}

extension Slider {
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    // Tracks previous location
    previousLocation = touch.location(in: self)
    
    // 2
    if pointThumbImageView.frame.contains(previousLocation) {
      pointThumbImageView.isHighlighted = true
    }
    
    // 3
    return pointThumbImageView.isHighlighted
  }
    
    // Tracks current location
    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
      let location = touch.location(in: self)
      
      // 1
      let deltaLocation = location.x - previousLocation.x
      let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
      
      previousLocation = location
      
      // Checks the boundaries
      if pointThumbImageView.isHighlighted {
        lowerValue += deltaValue
        lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                upperValue: upperValue)
      }
      
        upperValue += deltaValue
        upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                upperValue: maximumValue)
      // 3
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      
      updateLayerFrames()
      
      CATransaction.commit()
      
      return true
    }

    // 4
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
      return min(max(value, lowerValue), upperValue)
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
      pointThumbImageView.isHighlighted = false
    }
}
