//
//  JokeViewController.swift
//  HomeWork2
//
//  Created by Карина on 19.09.2022.
//

import UIKit

class JokeViewController: UIViewController {

    @IBOutlet var questionTF: UITextView!
    @IBOutlet var answerTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configur(with joke: JokeTwo) {
        questionTF.text = joke.setup
        answerTF.text = joke.punchline
    }
    
}

