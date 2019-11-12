//
//  ViewController.swift
//  MoodMusic
//
//  Created by Omari Matthews on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

import UIKit
import SpotifyLogin

class ViewController: UIViewController {
    
    
    let allQuestions = QuestionBank()
    var questionNumber : Int = 0
    var answers = [String]()
    
    var loginButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nextQuestion()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAlert),
                                               name: .SpotifyLoginSuccessful,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // handles button presses
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        answers.append(sender.titleLabel?.text ?? "no answer")
        
        questionNumber += 1
        
        nextQuestion()
        
    }
    
    // handles the connect button press
    @IBAction func showAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Connect Button Clicked", message: "yeah you clicked it", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()
        })
        
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    // updates the UI to display all the info pertaining to the next question
    func updateUI() {
        
        // chech to see if spotify is authed
        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            if error != nil {
                print(error)
            } else {
                print("user is logged in")
            }
        }
        
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
            btn.frame = CGRect(x: (Int(screenSize.width)/2)-100, y: btnY, width: 200, height: btnHeight)
            btn.contentMode = UIView.ContentMode.scaleToFill
            btnY += btnHeight + 5
            btn.addTarget(self, action: #selector(self.optionButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
        // adds a connect button at the bottom of the thing as a proof of concept for navigating to the connect page
       let authButton = SpotifyLoginButton(viewController: self, scopes: [.streaming, .userLibraryRead])
        btnY += btnHeight
        authButton.frame = CGRect(x: (Int(screenSize.width)/2)-100, y: btnY, width: 200, height: btnHeight)
        authButton.contentMode = UIView.ContentMode.scaleToFill
        self.view.addSubview(authButton)
        
        
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
        SpotifyLogin.shared.logout()
    }
    


}

