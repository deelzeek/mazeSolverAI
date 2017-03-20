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
    //private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.tile = self.childNode(withName: "tileMap") as? SKTileMapNode
        
        if let tile = self.tile {
            let path = Bundle.main.path(forResource: "mazethree.txt", ofType: nil)
            do {
                let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
                let lines = fileContents.components(separatedBy: "\n")
                print(lines)
                
                for row in 0..<lines.count {
                    let items = lines[row].components(separatedBy: " ")
                    
                    for column in 0..<items.count {
                        
                        if items[column] != "00" {
                            let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
                            //let aTile = SKTileDefinition(texture: SKTexture(imageNamed: "Grass_Grid_Center"))
                            //let tileGroup = SKTileGroup(tileDefinition: aTile)
                            self.tile?.setTileGroup(aTile, forColumn: column, row: 7 - row)
                            print("column: \(column), row: \(row)")
                            
                        }

                    }
                }
            } catch {
                print("Error loading map")
            }

            //label.alpha = 0.0
            //label.run(SKAction.fadeIn(withDuration: 2.0))
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
        //case 0x31:
            /*if let tile = self.tile {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }*/
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            print(tile?.tileSet.tileGroups.first?.name)
           
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
