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
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        answers.append(sender.titleLabel?.text ?? "no answer")
        
        questionNumber += 1
        
        nextQuestion()
    }
    
    func updateUI() {
        option1.setTitle(allQuestions.list[questionNumber].option1, for: .normal)
        option2.setTitle(allQuestions.list[questionNumber].option2, for: .normal)
        option3.setTitle(allQuestions.list[questionNumber].option3, for: .normal)
        option4.setTitle(allQuestions.list[questionNumber].option4, for: .normal)
    }
    
    func nextQuestion() {
        
        if questionNumber < 2 {
            questionLabel.text  = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome!", message: "You've finished the quiz!", preferredStyle: .alert)
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

