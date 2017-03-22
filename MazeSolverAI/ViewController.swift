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
    
    var individium : Individual?
    var pop : Population?
    var startOn : Bool = false
    var generation: Int = 1
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        
        
        //individium = Individual(newDna: DNA(0.5), start: Coordinate(0,1), dest: Coordinate(12,12))
        //print(individium?.getPath().description)
        
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
            //view.showsNodeCount = true
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        startOn = true
        pop = Population(number: 1000, mutationLevel: 0.1)
        
        let queue = DispatchQueue(label: "com.usmani.deel", qos: .userInitiated)
        
        queue.async {
            while self.startOn {
                self.pop?.start(completion: {
                    (finished, fittest) in
                    let x  = fittest.getSuccessTil().x
                    let y = fittest.getSuccessTil().y
                    if x == 6 && y == 7 {
                        self.startOn = false
                    }
                    //let rand = Int.random(range: (0..<3))
                    DispatchQueue.main.async {
                        self.generationLabel.stringValue = "Generation #\(self.generation)"
//                        switch rand {
//                        case 0:
//                            self.scene?.updateMaze(MazeLevels.Level1)
//                        case 1:
//                            self.scene?.updateMaze(MazeLevels.Level2)
//                        case 2:
//                            self.scene?.updateMaze(MazeLevels.Level3)
//                        default:
//                             self.scene?.updateMaze(MazeLevels.Level3)
//                        }
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

