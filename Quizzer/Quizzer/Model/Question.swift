//
//  Question.swift
//  Quizzer
//
//  Created by phoebe MBP13 on 3/4/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    
    init(text : String, correctAnswer : Bool) {
        questionText = text
        answer = correctAnswer
    }
}
