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
    @IBOutlet var generationLabel: NSTextField!
    @IBOutlet var bingoLabel: NSTextField!
    @IBOutlet var bestFitnessLabel: NSTextField!
    @IBOutlet var worstFitness: NSTextField!
    @IBOutlet var fittestCoor: NSTextField!
    @IBOutlet var newMazeButton: NSButton!
    @IBOutlet var solveButton: NSButton!
    
    var individium : Individual?
    //var pop : Population?
    var startOn : Bool = false
    var generation: Int = 1
    var scene: GameScene?
    //var level: MazeLevels?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        bingoLabel.isHidden = true
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: GAME_SCENE_NAME) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                self.scene = scene as! GameScene
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.wantsLayer = true
            view.showsFPS = true
            view.preferredFramesPerSecond = FRAMES_PER_SEC
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        startOn = true
        bingoLabel.isHidden = true
        
        //let queue = DispatchQueue(label: QUEUE_NAME, qos: .userInitiated, attributes: .concurrent)
        //let mainQueue = DispatchQueue.main //DispatchQueue(label: "com.plovlover.love", qos: .userInitiated)
        
        DispatchQueue.global().async {
            while self.startOn {
                self.scene?.start(completion: {
                    (finished, fittest, bestie, worstie) in

                    let x  = fittest.getSuccessTil().x
                    let y = fittest.getSuccessTil().y
                    
                    
                    DispatchQueue.main.sync {
                        self.generationLabel.stringValue = "Generation #\(self.generation)"
                        self.bestFitnessLabel.stringValue = "Best fitness: \(bestie)"
                        self.worstFitness.stringValue = "Worst fitness: \(worstie)"
                        self.fittestCoor.stringValue = "x:\(fittest.getSuccessTil().x), y: \(fittest.getSuccessTil().y)"

                        self.scene?.drawFittest(fittest)
                        
                    }
                    
                    if x == DESTINATION_X && y == DESTINATION_Y {
                        self.startOn = false
                        self.bingoLabel.isHidden = false
                        
                    }
                    
                   
                    
                })
                
                self.generation = self.generation + 1
            }
        }

        
        solveButton.isEnabled = false
        newMazeButton.isEnabled = false
        stopButton.isEnabled = true
        startButton.isEnabled = false
    }
    
    @IBAction func stopAction(_ sender: Any) {
        self.generation = 1
        startOn = false
        startButton.isEnabled = true
        stopButton.isEnabled = false
        bingoLabel.isHidden = true
        solveButton.isEnabled = true
        newMazeButton.isEnabled = true
        self.scene?.createPopulation(number: Int(self.populationSlider.intValue), mutation: Int(self.mutationSlider.intValue))
        //self.scene?.generateMazeNodes()
        //scene?.updateMaze(level!)
    }
    
    @IBAction func newMazeAction(_ sender: Any) {
        self.scene?.newMaze(population: Int(self.populationSlider.intValue), mutation: Int(self.mutationSlider.intValue))
    }
    
    @IBAction func solveAction(_ sender: Any) {
        self.scene?.solveMaze()
    }
    
    
    @IBAction func sliderAction(_ sender: NSSlider) {
        let currentValue = sender.intValue
        self.populationText.stringValue = "Population: \(currentValue)"
    }
    @IBAction func mutationSlidetAction(_ sender: NSSlider) {
        let currentValue = sender.floatValue
        let value = currentValue/Float(1000)
        print(Int(self.mutationSlider.intValue))
        self.mutationText.stringValue = "Mutation: \(value)"
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColor = CGColor(red: 38.0/256.0, green: 38.0/256.0, blue: 38.0/256.0, alpha: 1.0)
            
            self.view.layer?.backgroundColor = color
        }
        
    }
    
}

