//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    var storyIndexState: Int = 1
    let access = StoryBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO Step 3: Set the text for the storyTextView, topButton, bottomButton, and to T1_Story, T1_Ans1, and T1_Ans2
        updateView()
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
            // TODO Step 4: Write an IF-Statement to update the views
        if storyIndexState == 1{
        if sender.tag == 1 {
            storyIndexState = 3
            updateView()
        }
        else if sender.tag == 2{
          storyIndexState = 2
            updateView()
        }
        }
        else if storyIndexState == 2{
            if sender.tag == 1 {
                storyIndexState = 3
                updateView()
                
            }
            else if sender.tag == 2{
                storyIndexState = 4
                updateView()
            }
        }
        else if storyIndexState == 3{
            if sender.tag == 1 {
                storyIndexState = 6
                updateView()
                
            }
            else if sender.tag == 2 {
                storyIndexState = 5
                updateView()
            }
        }
        else if storyIndexState == 6 || storyIndexState == 5 || storyIndexState == 4 {
            if sender.tag == 1 || sender.tag == 2 {
                generateAlert()
                }
        }
    }
    
    func startOver(){
        storyIndexState = 1
        self.storyTextView.text = self.access.list[self.storyIndexState-1].story
        self.topButton.setTitle(self.access.list[self.storyIndexState-1].answer1, for: .normal)
        self.bottomButton.setTitle(self.access.list[self.storyIndexState-1].answer2, for: .normal)
    }
    
    
    func updateView(){
        
            self.storyTextView.text = self.access.list[self.storyIndexState-1].story
            self.topButton.setTitle(self.access.list[self.storyIndexState-1].answer1, for: .normal)
            self.bottomButton.setTitle(self.access.list[self.storyIndexState-1].answer2, for: .normal)
        
    }
    
        func generateAlert(){
            let alert = UIAlertController(title: "End of story", message: "Do you want to restart?", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(alertButton)
            present(alert, animated: true, completion: nil)
        }

}

