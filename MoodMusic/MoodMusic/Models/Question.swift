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
    let options : Array<String>
    
    // initialize with a string as the label and a list of string that are the choices
    // ex: ["pop", "edm", "classical"]
    init(text: String, options: Array<String>) {
        questionText = text;
        
        self.options = options
    }
    
}
