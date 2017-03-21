//
//  ViewController.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 20/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    @IBOutlet var startButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    @IBOutlet var populationText: NSTextField!
    @IBOutlet var mutationText: NSTextField!
    @IBOutlet var populationSlider: NSSlider!
    @IBOutlet var mutationSlider: NSSlider!
    @IBOutlet var mazesPopUpButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.wantsLayer = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        stopButton.isEnabled = true
        startButton.isEnabled = false
    }
    
    @IBAction func stopAction(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    @IBAction func mazePopUpAction(_ sender: Any) {
        print(self.mazesPopUpButton.indexOfSelectedItem)
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColor = CGColor(red: 38.0/256.0, green: 38.0/256.0, blue: 38.0/256.0, alpha: 1.0)
            
            self.view.layer?.backgroundColor = color
        }
        
    }
    
}

