//
//  ViewController.swift
//  MHP
//
//  Created by Peter Itskovich on 2/12/18.
//  Copyright © 2018 Peter Itskovich. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var door1: UIImageView!
    @IBOutlet weak var door2: UIImageView!
    @IBOutlet weak var door3: UIImageView!
    @IBOutlet weak var arrow1: UIImageView!
    @IBOutlet weak var arrow2: UIImageView!
    @IBOutlet weak var arrow3: UIImageView!
    @IBOutlet weak var doorSelector: UISegmentedControl!
    @IBOutlet weak var keepSelector: UISegmentedControl!
    @IBOutlet weak var selectLBL: UILabel!
    @IBOutlet weak var keepTotal: UILabel!
    @IBOutlet weak var keepWin: UILabel!
    @IBOutlet weak var keepLoss: UILabel!
    @IBOutlet weak var switchTotal: UILabel!
    @IBOutlet weak var switchWin: UILabel!
    @IBOutlet weak var switchLoss: UILabel!
    @IBOutlet weak var revealBTN: UIButton!
    @IBOutlet weak var showBTN: UIButton!
    @IBOutlet weak var resetBTN: UIButton!
    
    
    var imageView1: UIImageView?
    var imageView2: UIImageView?
    
    var doorWinner: Int = 0
    var playerChoice: Int = 0
    var doorRevealed: Int = 0
    
    var KeepTotalCounter: Int = 0
    var SwitchTotalCounter: Int = 0
    var KeepWinCounter: Int = 0
    var SwitchWinCounter: Int = 0
    var KeepLossCounter: Int = 0
    var SwitchLossCounter: Int = 0
    
    var isWinner: Bool = false
    
    let winSoundURL = Bundle.main.url(forResource: "WINNER", withExtension: "WAV")
    var winSound: SystemSoundID = 0
    let loserSoundURL = Bundle.main.url(forResource: "LoserHorns", withExtension: "wav")
    var loserSound: SystemSoundID = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AudioServicesCreateSystemSoundID(winSoundURL! as CFURL, &winSound)
        AudioServicesCreateSystemSoundID(loserSoundURL! as CFURL, &loserSound)
        
        doorWinner = Int((arc4random() % 3) + 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doorSelected(sender: AnyObject) {
        selectLBL.isHidden = true
        revealBTN.isHidden = false
        doorSelector.isHidden = true
        
        if(doorSelector.selectedSegmentIndex == 0){
            playerChoice = 1
        }
        if(doorSelector.selectedSegmentIndex == 1){
            playerChoice = 2
        }
        if(doorSelector.selectedSegmentIndex == 2){
            playerChoice = 3
        }
        showArrow();
    }
    func showArrow(){
        if(playerChoice == 1){
            arrow1.isHidden = false;
            arrow2.isHidden = true;
            arrow3.isHidden = true;
        }
        if(playerChoice == 2){
            arrow1.isHidden = true;
            arrow2.isHidden = false;
            arrow3.isHidden = true;
        }
        if(playerChoice == 3){
            arrow1.isHidden = true;
            arrow2.isHidden = true;
            arrow3.isHidden = false;
        }
    }
    @IBAction func revealDoor(sender: AnyObject) {
        var selectionRepeat:Bool = true
        
        while (selectionRepeat){
            doorRevealed = Int((arc4random() % 3 ) + 1)
            if (doorRevealed != doorWinner && doorRevealed != playerChoice){
                selectionRepeat = false
            }
        }
        
        if (doorRevealed == 1) {revealDoor1()}
        if (doorRevealed == 2) {revealDoor2()}
        if (doorRevealed == 3) {revealDoor3()}
        
        revealBTN.isHidden = true
        keepSelector.isHidden = false
    }
    
    func revealDoor1() {
        if (doorWinner == 1) {
            imageView2 = UIImageView(image: UIImage(named:"winner")!)
            imageView2?.tag = 100
        }
        else {
            imageView2 = UIImageView(image: UIImage(named:"loser2")!)
            imageView2?.tag = 100
        }
        
        imageView2?.frame = CGRect(x: 0, y: 45, width: 82, height: 72)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.50)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door1, cache: true)
        door1.addSubview(imageView2!)
        UIView.commitAnimations()
    }
    func revealDoor2() {
        if (doorWinner == 2) {
            imageView2 = UIImageView(image: UIImage(named:"winner")!)
            imageView2?.tag = 100
        }
        else {
            imageView2 = UIImageView(image: UIImage(named:"loser2")!)
            imageView2?.tag = 100
        }
        
        imageView2?.frame = CGRect(x: 220, y: 45, width: 82, height: 72)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.50)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door2, cache: true)
        door1.addSubview(imageView2!)
        UIView.commitAnimations()
    }
    func revealDoor3() {
        if (doorWinner == 3) {
            imageView2 = UIImageView(image: UIImage(named:"winner")!)
            imageView2?.tag = 100
        }
        else {
            imageView2 = UIImageView(image: UIImage(named:"loser2")!)
            imageView2?.tag = 100
        }
        
        imageView2?.frame = CGRect(x: 450, y: 45, width: 82, height: 72)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.50)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door3, cache: true)
        door1.addSubview(imageView2!)
        UIView.commitAnimations()
    }

    @IBAction func showResult(sender: AnyObject) {
        revealDoor1()
        revealDoor2()
        revealDoor3()
        showBTN.isHidden = true;
        resetBTN.isHidden = false;
        
        keepTotal.text = KeepTotalCounter.description
        switchTotal.text = SwitchTotalCounter.description
        keepWin.text = KeepWinCounter.description
        keepLoss.text = KeepLossCounter.description
        switchWin.text = SwitchWinCounter.description
        switchLoss.text = SwitchLossCounter.description
        
        if (isWinner){
            AudioServicesPlaySystemSound(winSound);
        }
        else{
            AudioServicesPlaySystemSound(loserSound);
        }
    }
    
    @IBAction func keepSwitch(sender: AnyObject){
        if(keepSelector.selectedSegmentIndex == 1)
        {
            if (doorRevealed == 1)
            {
                if (playerChoice == 2)
                {
                    playerChoice = 3
                }
                else{
                    playerChoice = 2
                }
            }
            if (doorRevealed == 2)
            {
                if (playerChoice == 1)
                {
                    playerChoice = 3
                }
                else{
                    playerChoice = 1
                }
            }
            if (doorRevealed == 3)
            {
                if (playerChoice == 1)
                {
                    playerChoice = 2
                }
                else{
                    playerChoice = 1
                }
            }
            showArrow()
            SwitchTotalCounter = SwitchTotalCounter + 1
            if(playerChoice == doorWinner)
            {
                SwitchWinCounter = SwitchWinCounter + 1
                isWinner = true;
            }
            else{
                SwitchLossCounter = SwitchLossCounter + 1
                isWinner = false
            }
        }
        else{
            KeepTotalCounter = KeepTotalCounter + 1
            if(playerChoice == doorWinner)
            {
                KeepWinCounter = KeepWinCounter + 1
                isWinner = true;
            }
            else{
                KeepLossCounter = KeepLossCounter + 1
                isWinner = false
            }
        }
        keepSelector.isHidden = true;
        showBTN.isHidden = false;
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        doorWinner = Int((arc4random() % 3) + 1)
        resetBTN.isHidden = true
        
        resetDoors()
        
        arrow1.isHidden = true
        arrow2.isHidden = true
        arrow3.isHidden = true
        doorSelector.isHidden = false
        doorSelector.selectedSegmentIndex = UISegmentedControlNoSegment
        keepSelector.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    func resetDoors() {
        imageView1 = UIImageView(image: UIImage (named:"door2")!)
        imageView1?.frame = CGRect(x: 0, y: 0, width: 82, height: 256);
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door1, cache: true)
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.viewWithTag(101)?.removeFromSuperview()
        //door1.addSubview(imageView1!)
        UIView.commitAnimations()
        
        imageView1 = UIImageView(image: UIImage (named:"door2")!)
        imageView1?.frame = CGRect(x: 220, y: 0, width: 82, height: 256);
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door2, cache: true)
        imageView2?.removeFromSuperview()
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.viewWithTag(101)?.removeFromSuperview()
        //door2.addSubview(imageView1!)
        UIView.commitAnimations()
        
        imageView1 = UIImageView(image: UIImage (named:"door2")!)
        imageView1?.frame = CGRect(x: 450, y: 0, width: 82, height: 256);
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: door3, cache: true)
        imageView2?.removeFromSuperview()
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.viewWithTag(101)?.removeFromSuperview()
        //door3.addSubview(imageView1!)
        UIView.commitAnimations()
    }
}





























