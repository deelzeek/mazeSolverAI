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
    @IBOutlet var generationLabel: NSTextField!
    @IBOutlet var bingoLabel: NSTextField!
    @IBOutlet var bestFitnessLabel: NSTextField!
    @IBOutlet var worstFitness: NSTextField!
    
    var individium : Individual?
    var pop : Population?
    var startOn : Bool = false
    var generation: Int = 1
    var scene: GameScene?
    var level: MazeLevels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        bingoLabel.isHidden = true
        level = MazeLevels.Level1

        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                self.scene = scene as! GameScene
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.wantsLayer = true
            view.showsFPS = true
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        startOn = true
        bingoLabel.isHidden = true
        mazesPopUpButton.isEnabled = false
        pop = nil
        pop = Population(number: Int(self.populationSlider.intValue), mutationLevel: 0.1, levelPeaks: LevelPeaks(level: level!), level: level!)
        
        let queue = DispatchQueue(label: "com.plovlover.deel", qos: .userInitiated)
        
        queue.async {
            while self.startOn {
                self.pop?.start(completion: {
                    (finished, fittest, bestie, worstie) in

                    let x  = fittest.getSuccessTil().x
                    let y = fittest.getSuccessTil().y
                    if x == 14 && y == 15 {
                        self.startOn = false
                        self.bingoLabel.isHidden = false
                    }
                    
                    DispatchQueue.main.sync {
                        self.generationLabel.stringValue = "Generation #\(self.generation)"
                        self.bestFitnessLabel.stringValue = "Best fitness: \(bestie)"
                        self.worstFitness.stringValue = "Worst fitness: \(worstie)"
                        self.scene?.updateMaze(fittest: fittest)
                        
                    }
                    
                })
                
                self.generation = self.generation + 1
            }
        }
        

        stopButton.isEnabled = true
        startButton.isEnabled = false
    }
    
    @IBAction func stopAction(_ sender: Any) {
        self.generation = 1
        startOn = false
        startButton.isEnabled = true
        stopButton.isEnabled = false
        mazesPopUpButton.isEnabled = true
        bingoLabel.isHidden = true
        scene?.updateMaze(level!)
    }
    
    @IBAction func mazePopUpAction(_ sender: Any) {
        let levelChosen: Int = self.mazesPopUpButton.indexOfSelectedItem
        switch levelChosen {
        case 0:
            self.level = MazeLevels.Level1
            print("levl1")
        case 1:
            self.level = MazeLevels.Level2
            print("levl2")
        case 2:
            self.level = MazeLevels.Level3
            print("levl3")
        default:
            self.level = MazeLevels.Level1
            print("levl4")
        }
        self.scene?.clearScreen()
        self.scene?.updateMaze(self.level!)
                
    }
    
    @IBAction func sliderAction(_ sender: NSSlider) {
        var currentValue = sender.intValue
        self.populationText.stringValue = "Population: \(currentValue)"
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColor = CGColor(red: 38.0/256.0, green: 38.0/256.0, blue: 38.0/256.0, alpha: 1.0)
            
            self.view.layer?.backgroundColor = color
        }
        
    }
    
}

