//
//  Individual.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation
import Cocoa


struct Coordinate {
    var x: Int
    var y: Int
    
    init(_ x: Int,_ y: Int) {
        self.x = x
        self.y = y
    }
}


class Individual {
    
    private var gene : DNA
    private var path: [Coordinate] = []
    private var successTil: Coordinate
    private var startPosition: Coordinate
    private var destination: Coordinate
    private var steps:Int = 0
    
    init(mutaLevel: Double, start: Coordinate, dest: Coordinate) {
        self.gene = DNA(mutationLevel: mutaLevel)
        self.startPosition = start
        self.successTil = start
        self.destination = dest
        //print("Chromos: \(gene.genes)")
        pathCreator()
    }
    
    init(newDna: DNA, start: Coordinate, dest: Coordinate) {
        self.gene = newDna
        self.destination = dest
        self.startPosition = start
        self.successTil = start
        //print("Chromos: \(gene.genes)")
        pathCreator()
        
    }
    
    public func getStepsAchieved() -> Int {
        return self.steps
    }

    
    public func getPath() -> [Coordinate] {
        return self.path
    }
    
    func setLastSuccess(last: Coordinate) {
        self.successTil = last
    }
    
    func mutate() {
        self.gene.mutate()
    }
    
    public func getSuccessTil() -> Coordinate {
        return self.successTil
    }
    
    public func fitness() -> Int {
        return Int(sqrt(pow(Double(successTil.x - destination.x), 2) + pow(Double(successTil.y - destination.y), 2)))
    }
    
    public func fitness(coor: Coordinate) -> Int {
        return Int(sqrt(pow(Double(coor.x - destination.x), 2) + pow(Double(coor.y - destination.y), 2)))
    }
    
    private func pathCreator() {
        var pathTemp : [Coordinate] = []
        
        pathTemp.append(startPosition)
        
        for current in 0..<gene.genes.count-1 {
            //let random = Int.random(range: Range(0...3))
            //let yRandom = Int.random(range: (0..3))
            
            var xMove: Int = 0
            var yMove: Int = 0
            
            switch gene.genes[current] {
            case .North:
                yMove = 1
            case .South:
                yMove = -1
            case .East:
                xMove = 1
            case .West:
                xMove = -1
            default:
                continue
            }

            let lastX = pathTemp.last?.x
            let lastY = pathTemp.last?.y
            
            if lastX! + xMove == -1 || lastY! + yMove == -1 || lastX! + xMove == 9 || lastX! + xMove == 9 {
                pathTemp.append(Coordinate(lastX!, lastY!))
            } else {
                pathTemp.append(Coordinate(lastX! + xMove, lastY! + yMove))
            }
            
        }
        
        self.path = pathTemp
    }
    
    public func getGene() -> [NextStep] {
        return self.gene.genes
    }
    
    
    public func checkPath(maze: Array<Array<Int>>){
        
        let columns = maze.count
        let rows = maze.count
        
        var prevX = path[0].x
        var prevY = path[0].y
        
        for num in 1..<path.count {
            let pathX = Int(self.path[num].x)
            let pathY = Int(self.path[num].y)
            if pathX != prevX || pathY != prevY {
                if (pathX < columns) && (pathY < rows) {
                    if let mazeRow: Int = maze[pathX][pathY] {
                        if mazeRow == 0 {
                            self.bestFit(coor: path[num], step: num)
                            prevX = pathX
                            prevY = pathY
                        } else if mazeRow == 1 {
                            return
                        }
                    }
                } else {
                    //self.successTil = temp
                    return
                }
            } else {
                return
            }
           
        }
        
        
    }
    
    private func bestFit(coor: Coordinate, step: Int) {
//        let champ = fitness()
//        let vacant = fitness(coor: coor)
//        if vacant < champ {
//            self.successTil = coor
//        }
        if self.steps <= step {
            self.steps = step
            self.successTil = coor
        }
    }
    
    
    
}
