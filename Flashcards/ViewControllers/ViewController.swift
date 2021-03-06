//
//  ViewController.swift
//  Flashcards
//
//  Created by Abu Butt on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        frontLabel.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
}

