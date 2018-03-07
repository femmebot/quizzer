//
//  ViewController.swift
//  Quizzer
//
//  Created by phoebe MBP13 on 3/4/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // initialize variables
    var button : UIButton?
    var label : UILabel?
    var scoreLabel = UILabel.init()
    var questionLabel = UITextView.init()
    let progressBarBackground = UIView.init()
    var progressBar = UIView.init()
    var allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var score : Int = 0
    var counter : Int = 0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpLabel(labelName: "Progress", yPos: 40)
        setUpLabel(labelName: "Score", yPos: 80)
        setUpButton(buttonName: "True", yPos: 150)
        setUpButton(buttonName: "False", yPos: 80)
        setUpProgressBar()
        setUpScoreLabel()
        setUpQuestionLabel()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func answerPressed(sender: UIButton){
        
        if sender.titleLabel?.text == "True" {
            pickedAnswer = true
        } else if sender.titleLabel?.text == "False" {
            pickedAnswer = false
        } else {
            print ("Hmm…")
        }
        
        checkAnswer()
        nextQuestion()
        
    }
    
    
    func setUpLabel(labelName : String, yPos : Int) {
        
        // init
        let label = UILabel.init()
        label.frame = CGRect(x:20,y:(yPos),width:100,height: 18)
        label.text = labelName
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
    }
    
    func setUpButton(buttonName : String, yPos : Int) {
        
        // init
        button = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: self.view.frame.size.height - CGFloat(yPos), width: self.view.frame.size.width - 40, height: 50))
        
        // title hex #43403c
        button?.setTitle(buttonName, for: .normal)
        button?.setTitleColor(UIColor(
            red: 0x43/255,
            green: 0x40/255,
            blue: 0x3c/255,
            alpha: 1.0), for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        // Hex to UIColor converter http://uicolor.xyz/#/hex-to-ui
        //        button?.setTitleColor(UIColor(red:0.01, green:0.42, blue:0.92, alpha:1.0), for: .normal)
        
        // target
        button?.addTarget(self, action: #selector(answerPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        // background color #e6e6e6
        // button?.backgroundColor = UIColor.lightGray
        button?.backgroundColor = UIColor(
            red: 0xe6/255,
            green: 0xe6/255,
            blue: 0xe6/255,
            alpha: 1.0)
        
        // border #ff5235
        button?.layer.cornerRadius = 5
//        button?.layer.borderWidth = 1
//        button?.layer.borderColor = UIColor(
//            red: 0xff/255,
//            green: 0x52/255,
//            blue: 0x35/255,
//            alpha: 1.0).cgColor
        
        // image
        // button?.setImage(UIImage.init(named: "image.png"), for: UIControlState.normal)
        
        // add to view
        self.view.addSubview(button!)
        
    }
    
    func setUpProgressBar() {
        
        // init
        let progressBarBackground = UIView(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: 68, width: self.view.frame.size.width - 40, height: 2))
        progressBar = UIView(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: 68, width: self.view.frame.size.width - 40, height: 2))
        progressBarBackground.backgroundColor = UIColor(
            red: 0xee/255,
            green: 0xee/255,
            blue: 0xee/255,
            alpha: 1.0)
        progressBar.backgroundColor = UIColor(
            red: 0xff/255,
            green: 0x52/255,
            blue: 0x35/255,
            alpha: 1.0)
        self.view.addSubview(progressBarBackground)
        self.view.addSubview(progressBar)

//        let progressBarFrame : CGRect = CGRect(x: self.view.frame.size.width/2 - (self.view.frame.size.width/2 - 20), y: 65, width: self.view.frame.size.width - 40, height: 2)
//        let progressBar : UIProgressView = UIProgressView.init(frame: progressBarFrame)
        
        //        progressBar.progress = Float(score / allQuestions.list.count)
//        progressBar.frame = CGRect(x: self.view.frame.size.width/2 - (self.view.frame.size.width/2 - 20), y: 65, width: self.view.frame.size.width - 40, height: 2)
//        progressBar.trackTintColor = UIColor.lightGray
//        progressBar.progressTintColor = UIColor.red
//        self.view.addSubview(progressBar)
        
    }
    
    func setUpScoreLabel() {
        
        scoreLabel.frame = CGRect(x:20,y:100,width:100,height: 24)
        scoreLabel.text = "\(score)/\(allQuestions.list.count)"
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.textColor = UIColor.darkGray
        self.view.addSubview(scoreLabel)
        
    }
    
    func setUpQuestionLabel() {
        
        questionLabel.frame = CGRect(x:20,y:170,width:self.view.frame.size.width - 40,height: 100)
        questionLabel.font = UIFont.systemFont(ofSize: 16)
        questionLabel.textColor = UIColor.black
        
        let firstQuestion = allQuestions.list[counter]
        questionLabel.text = firstQuestion.questionText
        
        self.view.addSubview(questionLabel)
        
    }
    
    
    func checkAnswer() {
        
        if pickedAnswer == allQuestions.list[counter].answer {
            //print ("right answer")
            ProgressHUD.showSuccess("Correct")
            score = score + 1
        } else {
            ProgressHUD.showError("Wrong answer!")
        }
        
        counter += 1
        
        updateUI()
        
    }
    
    func updateUI() {
        
        scoreLabel.text = String("\(score)/\(allQuestions.list.count)")
        print("\(score)/\(allQuestions.list.count)")
        
//        progressBar.progress = (Float(score / allQuestions.list.count))
        
        progressBar.frame.size.width = ((view.frame.size.width - 40) / CGFloat(allQuestions.list.count)) * CGFloat(counter)

        
    }
    
    func nextQuestion() {
        
        if counter < allQuestions.list.count {
            questionLabel.text = allQuestions.list[counter].questionText
            print("next question: \(allQuestions.list[counter].questionText)")
        } else {
            print ("end of quiz")
            let alert = UIAlertController(title: "Awesome!", message: "You've reached the end of the quiz. Try again?", preferredStyle: .alert )
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:{ (UIAlertAction) in self.startOver()
            })
            
            alert.addAction(restartAction)
            
            //            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            //                NSLog("The \"OK\" alert occurred.")
            //            }))
            //            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: { _ in
            //                NSLog("The \"Cancel\" alert occurred.")
            //            }))
            self.present(alert, animated: true, completion: nil)
            counter = 0
        }
    }
    
    func startOver() {
        
        counter = 0
        score = 0
        allQuestions.list = allQuestions.list.shuffled()
        nextQuestion()
        updateUI()
        
    }

}

