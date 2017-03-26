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
    var maze: Maze!
    
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
    
    var population: Population?
    var mazeArrRep: Array<Array<Int>>?
    
//    private var level: MazeLevels = .Level1
//    public var maze = Array<Array<Int>>()
//    private var levelPeaks : LevelPeaks = LevelPeaks(level: .Level1)
    
    
    //private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
         //createMaze()
    }
    
    override func sceneDidLoad() {
        createMaze()
        
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
    
    public func newMaze(population: Int, mutation: Double) {
        createMaze()
        createPopulation(number: population, mutation: mutation)
    }
    
    public func updateMaze(fittest: Individual) {
        
    }
    
    
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
        self.mazeArrRep = arrayReprOfMaze()
        
        // Remove existing maze cell sprites from the previous maze.
        mazeParentNode.removeAllChildren()
        
        // For each maze node in the maze graph, create a corresponding sprite.
        let graphNodes = maze.graph.nodes as? [GKGridGraphNode]
        for node in graphNodes! {
            // Get the position of the maze node.
            let x = Int(node.gridPosition.x)
            let y = Int(node.gridPosition.y)
            
            self.mazeArrRep?[x][y] = 0
            
            //print("generateMaze -> x: \(x), y: \(y)")
            
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
            
           // print("x: \(x), y: \(y)")
            
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
    
    public func start(completion:@escaping ((_ finished: Bool, _ fittest : Individual, _ bestFitness: Int, _ worstFitness: Int)->())) {
        self.population?.start({
            (finished, fittest, bestie, worstie) in
            completion(finished, fittest, bestie, worstie)
        }
        )
    }
    
    func drawFittest(_ solution: [GKGridGraphNode]) {
        
        generateMazeNodes()
        
        let actionDelay: TimeInterval = 0
        
        for i in 1...(solution.count - 2) {
            // Grab the position of the maze graph node.
            let x = Int(solution[i].gridPosition.x)
            let y = Int(solution[i].gridPosition.y)
            
            // Run the animation action on the maze sprite node.
            if let mazeNode = spriteNodes[x][y] {
                mazeNode.run(
                    SKAction.sequence(
                        [SKAction.colorize(with: SKColor.gray, colorBlendFactor: 1, duration: 0),
                         SKAction.wait(forDuration: actionDelay),
                         SKAction.colorize(with: SKColor.white, colorBlendFactor: 1, duration: 0),
                         SKAction.colorize(with: SKColor.lightGray, colorBlendFactor: 1, duration: 0)]
                    )
                )
            }
        }
    }
    
    func createPopulation(number ofPopulation: Int, mutation percent:Double) {
        // Grab the coordinates of the start and end maze sprite nodes.
        population = nil
        let startNodeX = Int(maze.startNode.gridPosition.x)
        let startNodeY = Int(maze.startNode.gridPosition.y)
        let endNodeX   = Int(maze.endNode.gridPosition.x)
        let endNodeY   = Int(maze.endNode.gridPosition.y)
        population = Population(number: ofPopulation, mutationLevel: percent, startPos: Coordinate(startNodeX, startNodeY), endPos: Coordinate(endNodeX, endNodeY), maze: self.mazeArrRep!)
    }
    
    private func arrayReprOfMaze() -> Array<Array<Int>> {
        var mazeCurrent = Array<Array<Int>>()
        
        for _ in 0...14 {
            var arr = Array<Int>()
            for _ in 0...14 {
                arr.append(1)
            }
            mazeCurrent.append(arr)
        }
        
        return mazeCurrent
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
            print("self.mazearr: \(self.mazeArrRep)")
        }
        
        /**
         Advances the game by creating a new maze or solving the existing maze if
         a click is detected.
         */
        override func mouseDown(with _: NSEvent) {
            createOrSolveMaze()
            print("self.mazearr: \(self.mazeArrRep)")
        }
    }
#endif


