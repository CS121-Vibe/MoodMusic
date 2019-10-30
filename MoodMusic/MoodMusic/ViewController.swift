//
//  ViewController.swift
//  MoodMusic
//
//  Created by Omari Matthews on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    var answers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        print("Button Pressed")
    }
    


}

