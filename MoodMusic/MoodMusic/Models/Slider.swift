//
//  Slider.swift
//  MoodMusic
//
//  Created by Nina on 12/12/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

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
