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
    //private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.tile = self.childNode(withName: "tileMap") as? SKTileMapNode
        
        if let _ = self.tile {
            updateMaze(.Level1)
            
        }
        
        // Create shape node to use during mouse interaction
        //let w = (self.size.width + self.size.height) * 0.05
        //self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    func updateMaze(_ level: MazeLevels) {
        self.level = level
        
//        if level == MazeLevels.Level3 {
//            let newTile = SKTileMapNode(tileSet: self.tile!.tileSet, columns: 24, rows: 24, tileSize: self.tile!.mapSize)
//            self.tile = newTile
//        }
        
        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
        
        do {
            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            let lines = fileContents.components(separatedBy: "\n")

            for row in 0..<lines.count {
                let items = lines[row].components(separatedBy: " ")
                
                for column in 0..<items.count {
                    
                    if items[column] != "00" {
                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
                        
                        self.tile?.setTileGroup(aTile, forColumn: column, row: 7 - row)
                        
                        
                    } else {
                        self.tile?.setTileGroup(nil, forColumn: column, row: 7 - row)
                    }
                    
                }
            }
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
