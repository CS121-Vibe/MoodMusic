//
//  ViewController.swift
//  MoodMusic
//
//  Created by Omari Matthews on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let allQuestions = QuestionBank()
    var questionNumber : Int = 0
    var answers = [String]()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nextQuestion()
    }
    
    // handles button presses
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        answers.append(sender.titleLabel?.text ?? "no answer")
        
        questionNumber += 1
        
        nextQuestion()
    }
    
    // updates the UI to display all the info pertaining to the next question
    func updateUI() {
        // contains all buttons on the survey page
        let buttons = [option1,option2,option3,option4]
        // loops over the options for the selected questions and renames the buttons to match the options
        for index in allQuestions.list[questionNumber].options.indices {
            buttons[index]?.setTitle(allQuestions.list[questionNumber].options[index], for: .normal)
        }
    }
    
    // advances to the next question in the question list
    func nextQuestion() {
        if questionNumber < 4 {
            questionLabel.text  = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome!", message: "You've finished the survey!", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    
    }
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
        answers = [String]()
    }
    


}

