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

struct LevelPeaks {
    var start: Coordinate
    var end: Coordinate
    var columns: Int
    var rows: Int
    
    init(level: MazeLevels) {
        switch level {
        case .Level1:
            self.start = EntryPointLevel1
            self.end = EndPointLevel1
            self.columns = 16
            self.rows = 16
        case .Level2:
            self.start = EntryPointLevel2
            self.end = EntryPointLevel2
            self.columns = 8
            self.rows = 8
        case .Level3:
            self.start = EntryPointLevel3
            self.end = EndPointLevel3
            self.columns = 8
            self.rows = 8
        }
    }
}


enum MazeLevels: String {
    case Level1 = "mazeone.txt"
    case Level2 = "mazetwo.txt"
    case Level3 = "mazethree.txt"
}



enum NextStep: Int {
    case North = 0, South = 1, East = 2 , West =  3, Stay = 4
}

let MAX_MOVES = 60

let EntryPointLevel1 = Coordinate(1,0)
let EndPointLevel1 = Coordinate(14,15)

let EntryPointLevel2 = Coordinate(1,0)
let EndPointLevel2 = Coordinate(6,7)

let EntryPointLevel3 = Coordinate(5,0)
let EndPointLevel3 = Coordinate(2,7)







