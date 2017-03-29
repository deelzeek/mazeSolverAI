//
//  Constants.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}




enum NextStep: Int {
    case North = 0, South = 1, East = 2 , West =  3, Stay = 4
}

//Amount of chromosomes
let MAX_MOVES = 100

//Destination point
let DESTINATION_Y = 0
let DESTINATION_X = 14

//Range limits of the maze
let MAZE_HORIZONRAL_LIMIT = 15

//Maze ROAD and WALL values

let WALL = 1
let ROAD = 0

let AMOUNT_OF_CANDITS_FOR_PARENT = 10
let FIND_PARENT_LESS = 25
let FRAMES_PER_SEC = 24

let QUEUE_NAME = "com.plovlover.geneticAlgo"
let GAME_SCENE_NAME = "GameScene"


