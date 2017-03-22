//
//  Labyrinth.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation

var sharedLabyrinth : Labyrinth?

class Labyrinth {
    var maze: Array<Array<Int>>
    
    class var sharedInstance: Labyrinth {
        return sharedLabyrinth!
    }
    
    class func initShared(maze: Array<Array<Int>>) {
        sharedLabyrinth = Labyrinth(maze: maze)
    }
    
    init(maze: Array<Array<Int>>) {
        self.maze = maze
    }
}
