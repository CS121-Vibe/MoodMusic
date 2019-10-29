//
//  Question.swift
//  MoodMusic
//
//  Created by Omari Matthews on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//



class Question {

    // label
    let questionText : String
    
    // list of choices
    let option1 : String
    let option2 : String
    let option3 : String
    let option4 : String
    
    // initialize with a string as the label and a list of string that are the choices
    // ex: ["pop", "edm", "classical"]
    init(text: String, options: Array<String>) {
        questionText = text;
        self.option1 = options[0]
        self.option2 = options[1]
        self.option3 = options[2]
        self.option4 = options[3]
    }
    
}
