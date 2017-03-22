//
//  GameScene.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 20/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var tile : SKTileMapNode?
    private var level: MazeLevels = .Level1
    public var maze = Array<Array<Int>>()
    //private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func sceneDidLoad() {
        // Get label node from scene and store it for use later
        self.tile = self.childNode(withName: "tileMap") as? SKTileMapNode
        
        if let _ = self.tile {
            updateMaze(.Level1)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    public func getMaze() -> Array<Array<Int>> {
        return self.maze
    }
    
    public func updateMaze(_ level: MazeLevels) {
        self.level = level
        
        
        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
        
        do {
            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            let lines = fileContents.components(separatedBy: "\n")

            for row in 0..<lines.count-1 {
                let items = lines[row].components(separatedBy: " ")
                var columnArray = Array<Int>()
                
                for column in 0..<items.count {
                    
                    if items[column] != "00" {
                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
                        self.tile?.setTileGroup(aTile, forColumn: column, row: 7 - row)
                        columnArray.append(1)
                        
                    } else {
                        self.tile?.setTileGroup(nil, forColumn: column, row: 7 - row)
                        columnArray.append(0)
                    }
                    
                }
                
                self.maze.append(columnArray)
            }
            
            //print(self.maze)
            Labyrinth.initShared(maze: self.maze)
            //print("Laby: \(Labyrinth.sharedInstance)")
        } catch {
            //print("Error loading map")
        }
    }
    
    public func updateMaze(fittest: Individual) {
        
        let closestX = fittest.getSuccessTil().x
        let closestY = fittest.getSuccessTil().y
        
        
        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
        
        do {
            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            let lines = fileContents.components(separatedBy: "\n")
            
            for row in 0..<lines.count-1 {
                let items = lines[row].components(separatedBy: " ")
                var columnArray = Array<Int>()
                
                for column in 0..<items.count {
                    
                    if items[column] != "00" {
                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
                        self.tile?.setTileGroup(aTile, forColumn: column, row: 7 - row)
                        columnArray.append(1)
                        
                    } else {
                        self.tile?.setTileGroup(nil, forColumn: column, row: 7 - row)
                        columnArray.append(0)
                    }
                    
                }
                
                self.maze.append(columnArray)
            }
            
            for n in 0..<fittest.getGene().count {
                let xValue = fittest.getPath()[n].x
                let yValue = fittest.getPath()[n].y
                //print("xVal: \(xValue), yVal: \(yValue)")
                if xValue != closestX && yValue != closestY {
                    if maze[xValue][yValue] == 0 {
                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Water"})
                        self.tile?.setTileGroup(aTile, forColumn: yValue, row:  7 - xValue)
                    }
                } else {
                    let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Water"})
                    self.tile?.setTileGroup(aTile, forColumn: yValue, row:  7 - xValue)
                    if yValue == 6 && xValue == 6 {
                        self.tile?.setTileGroup(aTile, forColumn: 7, row:  1)
                        //print("really?")
                    }
                    break
                }
            }
            
            //print(self.maze)
            Labyrinth.initShared(maze: self.maze)
            //print("Laby: \(Labyrinth.sharedInstance)")
        } catch {
            print("Error loading map")
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        
        case 126:
            switch self.level {
            case .Level1:
                updateMaze(.Level3)
            case .Level2:
                updateMaze(.Level1)
            case .Level3:
                updateMaze(.Level2)
            default:
                updateMaze(.Level1)
            }
            
        case 125:
            switch self.level {
            case .Level1:
                updateMaze(.Level2)
            case .Level2:
                updateMaze(.Level3)
            case .Level3:
                updateMaze(.Level1)
            default:
                updateMaze(.Level1)
            }
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            print(tile?.tileSet.tileGroups.first?.name)
           
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
