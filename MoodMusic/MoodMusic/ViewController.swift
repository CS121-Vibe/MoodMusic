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
        
        
    }
    
    @IBAction func surveyButtonPressed(_ sender: UIButton) {
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
        //magic numbers
        let screenSize: CGRect = UIScreen.main.bounds
        var btnY = Int(screenSize.height)/2
        let btnHeight = 40
        
        //clears screen to add the new question
        for view in self.view.subviews{
                view.removeFromSuperview()
        }
        
        // add the text of the question at the top
        let question = UILabel()
        question.text  = allQuestions.list[questionNumber].questionText
        question.frame = CGRect(x: (Int(screenSize.width)/2)-200, y: 100, width: 400, height: 150)
        question.textAlignment = NSTextAlignment.center
        self.view.addSubview(question)
        
        //add a number of buttons to represent the number of choices for the questions
        for index in allQuestions.list[questionNumber].options.indices {
            let btn = UIButton()
            btn.setTitle(allQuestions.list[questionNumber].options[index], for: .normal)
            btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            btn.frame = CGRect(x: (Int(screenSize.width)/2)-100, y: btnY, width: 200, height: btnHeight)
            btn.contentMode = UIView.ContentMode.scaleToFill
            btnY += btnHeight + 5
            btn.addTarget(self, action: #selector(self.optionButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
    }
    
    // advances to the next question in the question list
    func nextQuestion() {
        if questionNumber < 4 {
            //questionLabel.text  = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            print(answers[0])
            let alert = UIAlertController(title: "Awesome! you have chosen", message:  answers.joined(separator: " "), preferredStyle: .alert)
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

