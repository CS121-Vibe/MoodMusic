//
//  QuestionBank.swift
//  MoodMusic
//
//  Created by Omari Matthews on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

import Foundation


class QuestionBank {
    
    // holds the list of survey questions
    var list = [Question]()
    
    // initializes all of the questions listed
    init() {
        list.append(Question(text: "Where are you?",
                             options: ["Public Setting", "Living Room", "Car", "Bedroom", "Office","Outdoors"]))
        list.append(Question(text: "How many people?",
                             options: ["1", "2-4", "5-10", ">10"]))
        list.append(Question(text: "How loud?",
       options: ["Calm", "Loud", "Party"]))
        
        list.append(Question(text: "How formal?",
        options: ["Formal", "Casual", "Not Formal"]))
        
//        list.append(Question(text: "How loud?",
//        options: [slider]))
    }
    
}

//label = UILabel()
// label.frame = CGRect(x:0, y:30, width: self.view.frame.width, height:  self.view.frame.height)
// label.textColor = UIColor.white
// label.backgroundColor = UIColor.purple
// label.textAlignment = NSTextAlignment.center
// label.numberOfLines = 2
// label.font = UIFont(name: "Helvetica", size: 32)
// self.view.addSubview(label)
//
// slider = UISlider(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
// slider.center = self.view.center
// // Spotify's loundess metrics ranges from -60 to 0, so we will make [0,60] range for user's convenience
// slider.minimumValue = 0
// slider.maximumValue = 60
// slider.value = 30
// slider.tintColor = UIColor.cyan
// slider.thumbTintColor = UIColor.white
// slider.isContinuous = true
//
// self.view.addSubview(slider)


//if questionNumber == 2 {
//    slider.minimumTrackTintColor = UIColor(named: "MyLightRed")
//    slider.maximumTrackTintColor = UIColor(named: "MyDarkRed")
//    slider.setThumbImage(UIImage(named: "ThumbImage"), for: .normal)
//}


//class CustomSlider: UISlider {
//override func trackRect(forBounds bounds: CGRect) -> CGRect {
//    let point = CGPoint(x: bounds.minX, y: bounds.midY)
//    return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
//}
