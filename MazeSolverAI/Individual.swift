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
    
    init(mutaLevel: Int, start: Coordinate, dest: Coordinate) {
        self.gene = DNA(mutationLevel: mutaLevel)
        self.startPosition = start
        self.successTil = start
        self.destination = dest
    
        pathCreator()
    }
    
    init(newDna: DNA, start: Coordinate, dest: Coordinate) {
        self.gene = newDna
        self.destination = dest
        self.startPosition = start
        self.successTil = start
      
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
    
    public func fitness() -> Float {
        return Float(sqrt(pow(Double(successTil.x - destination.x), 2) + pow(Double(successTil.y - destination.y), 2)))
    }
    
    public func fitness(coor: Coordinate) -> Float {
        return Float(sqrt(pow(Double(coor.x - destination.x), 2) + pow(Double(coor.y - destination.y), 2)))
    }
    
    private func pathCreator() {
        var pathTemp : [Coordinate] = []
        
        pathTemp.append(startPosition)
        
        for current in 1..<gene.genes.count {
            
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
            
            pathTemp.append(Coordinate(lastX! + xMove, lastY! + yMove))

            
        }
        
        self.path = pathTemp
        
    }
    
    public func getGene() -> [NextStep] {
        return self.gene.genes
    }
    
    
    public func checkPath(maze: Array<Array<Int>>){
        
        let columns = maze.count
        let rows = maze.count

        
        for num in 0..<path.count {
            let pathX = Int(self.path[num].x)
            let pathY = Int(self.path[num].y)
                if (pathX < columns) && (pathY < rows) && (pathX >= 0) && (pathY >= 0){
                    if let mazeRow: Int = maze[pathX][pathY] {
                        if mazeRow == 0 {
                            self.bestFit(coor: path[num], step: num)
                        } else if mazeRow == 1 {
                            break
                        }
                    }
                } else {
                    break
                }
        }
        
        
    }
    
    private func bestFit(coor: Coordinate, step: Int) {
        let champ = fitness()
        let vacant = fitness(coor: coor)
        if vacant < champ {
            self.successTil = coor
            self.steps = step
        }
        
        
    }
    
    
    
}
