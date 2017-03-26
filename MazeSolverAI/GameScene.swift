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
    
    //private var tile : SKTileMapNode?
    
    /// Holds information about the maze.
    var maze = Maze()
    
    /// Whether the solution is currently displayed or not.
    var hasSolutionDisplayed = false
    
    /**
     Contains optional sprite nodes that are used to visualize the maze
     graph. The nodes are arranged in a 2D array (an array with rows and
     columns) so that the array index of a sprite node in this array
     corresponds to the coordinates of the node in the maze graph. A node at
     an index exists if the corresponding maze node exists; otherwise, the
     sprite node is nil.
     */
    @nonobjc var spriteNodes = [[SKSpriteNode?]]()
    
    
//    private var level: MazeLevels = .Level1
//    public var maze = Array<Array<Int>>()
//    private var levelPeaks : LevelPeaks = LevelPeaks(level: .Level1)
    
    
    //private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
         createMaze()
    }
    
    override func sceneDidLoad() {
//        // Get label node from scene and store it for use later
//        self.tile = self.childNode(withName: "tileMap") as? SKTileMapNode
//        
//        if let _ = self.tile {
//            updateMaze(.Level1)
//        }
//        
//        let mazeOne = loadMazeLevels(level: MazeLevels.Level1)
//        let mazeTwo = loadMazeLevels(level: MazeLevels.Level2)
//        let mazeThree = loadMazeLevels(level: MazeLevels.Level3)
//        
//        Labyrinth.initShared(maze1: mazeOne, maze2: mazeTwo, maze3: mazeThree)
        
    }
    
    // MARK: Methods
    
    /// Creates a new maze, or solves the newly created maze.
    func createOrSolveMaze() {
        if hasSolutionDisplayed {
            createMaze()
        }
        else {
            solveMaze()
        }
    }
    
    /**
     Creates a maze object, and creates a visual representation of that maze
     using sprites.
     */
    func createMaze() {
        maze = Maze()
        generateMazeNodes()
        hasSolutionDisplayed = false
    }
    
    /**
     Uses GameplayKit's pathfinding to find a solution to the maze, then
     solves it.
     */
    func solveMaze() {
        guard let solution = maze.solutionPath else {
            assertionFailure("Solution not retrievable from maze.")
            return
        }
        
        animateSolution(solution)
        hasSolutionDisplayed = true
    }
    
//    func loadMazeLevels(level: MazeLevels) -> Array<Array<Int>> {
//        
//        var mazeTemp = Array<Array<Int>>()
//        
//        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
//        
//        do {
//            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
//            let lines = fileContents.components(separatedBy: "\n")
//            for row in 0..<lines.count-1 {
//                let items = lines[row].components(separatedBy: " ")
//                var columnArray = Array<Int>()
//                //print("lines: \(lines.count), items: \(items.count)")
//                for column in 0..<items.count {
//                    
//                    if items[column] != "00" {
//                        columnArray.append(1)
//                        
//                    } else {
//                        columnArray.append(0)
//                    }
//                    
//                }
//                
//                mazeTemp.append(columnArray)
//                
//            }
//            
//        } catch {
//            print("Error loading map")
//        }
//
//        return mazeTemp
//        
//    }
    
    
//    public func getMaze() -> Array<Array<Int>> {
//        return self.maze
//    }
//    
//    public func clearScreen() {
//        for rows in 0..<16 {
//            for columns in 0..<16 {
//             self.tile?.setTileGroup(nil, forColumn: columns, row: rows)
//            }
//        }
//    }
    
    public func updateMaze(_ level: MazeLevels) {
//        self.level = level
//        self.levelPeaks = LevelPeaks(level: level)
//        //self.maze.removeAll()
//        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
//        
//        do {
//            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
//            let lines = fileContents.components(separatedBy: "\n")
//            self.maze.removeAll()
//            for row in 0..<lines.count-1 {
//                let items = lines[row].components(separatedBy: " ")
//                var columnArray = Array<Int>()
//                //print("lines: \(lines.count), items: \(items.count)")
//                for column in 0..<items.count {
//                    
//                    if items[column] != "00" {
//                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
//                        self.tile?.setTileGroup(aTile, forColumn: column, row: (levelPeaks.rows - 1) - row)
//                        columnArray.append(1)
//                        
//                    } else {
//                        self.tile?.setTileGroup(nil, forColumn: column, row: (levelPeaks.rows - 1) - row)
//                        columnArray.append(0)
//                    }
//                    
//                }
//                
//                self.maze.append(columnArray)
//                
//            }
//            
//            //print(self.maze)
//            //Labyrinth.initShared(maze: self.maze)
//            //print("Laby: \(Labyrinth.sharedInstance)")
//        } catch {
//            //print("Error loading map")
//        }
//        
//        //print(self.maze)
        
    }
    
    public func updateMaze(fittest: Individual) {
        
//        let closestX = fittest.getSuccessTil().x
//        let closestY = fittest.getSuccessTil().y
//        
//        //self.maze.removeAll()
//        let path = Bundle.main.path(forResource: level.rawValue, ofType: nil)
//        
//        do {
//            let fileContents = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
//            let lines = fileContents.components(separatedBy: "\n")
//            
//            for row in 0..<lines.count-1 {
//                let items = lines[row].components(separatedBy: " ")
//                var columnArray = Array<Int>()
//                
//                for column in 0..<items.count {
//                    
//                    if items[column] != "00" {
//                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Grass"})
//                        self.tile?.setTileGroup(aTile, forColumn: column, row: (levelPeaks.columns - 1) - row)
//                        columnArray.append(1)
//                        
//                    } else {
//                        self.tile?.setTileGroup(nil, forColumn: column, row: (levelPeaks.columns - 1) - row)
//                        columnArray.append(0)
//                    }
//                    
//                }
//                
//                //self.maze.append(columnArray)
//            }
//            
//            for n in 0..<fittest.getGene().count {
//                let xValue = fittest.getPath()[n].x
//                let yValue = fittest.getPath()[n].y
//                //print("xVal: \(xValue), yVal: \(yValue)")
//                if xValue != closestX && yValue != closestY {
//                    if maze[xValue][yValue] == 0 {
//                        let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Water"})
//                        self.tile?.setTileGroup(aTile, forColumn: yValue, row:  (levelPeaks.columns - 1) - xValue)
//                    }
//                } else {
//                    let aTile = self.tile?.tileSet.tileGroups.first(where: { $0.name == "Water"})
//                    self.tile?.setTileGroup(aTile, forColumn: yValue, row:  (levelPeaks.columns - 1) - xValue)
//                    if yValue == levelPeaks.end.x && xValue == (levelPeaks.end.y - 1) {
//                        self.tile?.setTileGroup(aTile, forColumn: levelPeaks.end.y, row:  (levelPeaks.rows - 1) - levelPeaks.end.x)
//                        //print("really?")
//                    }
//                    break
//                }
//            }
//            
//            //print(self.maze)
//            //Labyrinth.initShared(maze: self.maze)
//            //print("Laby: \(Labyrinth.sharedInstance)")
//        } catch {
//            print("Error loading map")
//        }
    }
    
    
//    override func keyDown(with event: NSEvent) {
//        switch event.keyCode {
//        
//        case 126:
//            switch self.level {
//            case .Level1:
//                updateMaze(.Level3)
//            case .Level2:
//                updateMaze(.Level1)
//            case .Level3:
//                updateMaze(.Level2)
//            default:
//                updateMaze(.Level1)
//            }
//            
//        case 125:
//            switch self.level {
//            case .Level1:
//                updateMaze(.Level2)
//            case .Level2:
//                updateMaze(.Level3)
//            case .Level3:
//                updateMaze(.Level1)
//            default:
//                updateMaze(.Level1)
//            }
//            
//        default:
//            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//            print(tile?.tileSet.tileGroups.first?.name)
//           
//        }
//    }
//    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    /// Generates sprite nodes that comprise the maze's visual representation.
    func generateMazeNodes() {
        // Initialize the an array of sprites for the maze.
        spriteNodes += [[SKSpriteNode?]](repeating: [SKSpriteNode?](repeating: nil, count: (Maze.dimensions * 2) - 1), count: Maze.dimensions
        )
        
        /*
         Grab the maze's parent node from the scene and use it to
         calculate the size of the maze's cell sprites.
         */
        let mazeParentNode = childNode(withName: "maze") as! SKSpriteNode
        let cellDimension = mazeParentNode.size.height / CGFloat(Maze.dimensions)
        
        // Remove existing maze cell sprites from the previous maze.
        mazeParentNode.removeAllChildren()
        
        // For each maze node in the maze graph, create a corresponding sprite.
        let graphNodes = maze.graph.nodes as? [GKGridGraphNode]
        for node in graphNodes! {
            // Get the position of the maze node.
            let x = Int(node.gridPosition.x)
            let y = Int(node.gridPosition.y)
            
            print("generateMaze -> x: \(x), y: \(y)")
            
            /*
             Create a maze sprite node and place the sprite at the correct
             location relative to the maze's parent node.
             */
            let mazeNode = SKSpriteNode(
                color: SKColor.darkGray,
                size: CGSize(width: cellDimension, height: cellDimension)
            )
            mazeNode.anchorPoint = CGPoint(x: 0, y: 0)
            mazeNode.position = CGPoint(x: CGFloat(x) * cellDimension, y: CGFloat(y) * cellDimension)
            
            // Add the maze sprite node to the maze's parent node.
            mazeParentNode.addChild(mazeNode)
            
            /*
             Add the maze sprite node to the 2D array of sprite nodes so we
             can reference it later.
             */
            spriteNodes[x][y] = mazeNode
        }
        
        // Grab the coordinates of the start and end maze sprite nodes.
        let startNodeX = Int(maze.startNode.gridPosition.x)
        let startNodeY = Int(maze.startNode.gridPosition.y)
        let endNodeX   = Int(maze.endNode.gridPosition.x)
        let endNodeY   = Int(maze.endNode.gridPosition.y)
        
        // Color the start and end nodes green and red, respectively.
        spriteNodes[startNodeX][startNodeY]?.color = SKColor.green
        spriteNodes[endNodeX][endNodeY]?.color     = SKColor.red
    }
    
    /// Animates a solution to the maze.
    func animateSolution(_ solution: [GKGridGraphNode]) {
        /*
         The animation works by animating sprites with different start delays.
         actionDelay represents this delay, which increases by
         an interval of actionInterval with each iteration of the loop.
         */
        var actionDelay: TimeInterval = 0
        let actionInterval = 0.005
        
        
        
        /*
         Light up each sprite in the solution sequence, except for the
         start and end nodes.
         */
        for i in 1...(solution.count - 2) {
            // Grab the position of the maze graph node.
            let x = Int(solution[i].gridPosition.x)
            let y = Int(solution[i].gridPosition.y)
            
            print("x: \(x), y: \(y)")
            
            /*
             Increment the action delay so this sprite is highlighted
             after the previous one.
             */
            actionDelay += actionInterval
            
            // Run the animation action on the maze sprite node.
            if let mazeNode = spriteNodes[x][y] {
                mazeNode.run(
                    SKAction.sequence(
                        [SKAction.colorize(with: SKColor.gray, colorBlendFactor: 1, duration: 0.2),
                         SKAction.wait(forDuration: actionDelay),
                         SKAction.colorize(with: SKColor.white, colorBlendFactor: 1, duration: 0),
                         SKAction.colorize(with: SKColor.lightGray, colorBlendFactor: 1, duration: 0.3)]
                    )
                )
            }
        }
    }
}

// MARK: OS X Input Handling

#if os(OSX)
    extension GameScene {
        /**
         Advances the game by creating a new maze or solving the existing maze if
         a key press is detected.
         */
        override func keyDown(with _: NSEvent) {
            createOrSolveMaze()
        }
        
        /**
         Advances the game by creating a new maze or solving the existing maze if
         a click is detected.
         */
        override func mouseDown(with _: NSEvent) {
            createOrSolveMaze()
        }
    }
#endif


