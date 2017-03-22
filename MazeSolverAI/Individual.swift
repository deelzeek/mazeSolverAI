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
        //print(self.successTil)
        return Int(sqrt(pow(Double(successTil.x - destination.x), 2) + pow(Double(successTil.y - destination.y), 2)))
    }
    
    public func fitness(coor: Coordinate) -> Int {
        //print(self.successTil)
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
                xMove = -1
            case .South:
                xMove = 1
            case .East:
                yMove = 1
            case .West:
                yMove = -1
            default:
                break
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
        let rows = maze[0].count
        //var temp = self.startPosition
        
        for num in 0..<path.count {
            //var temp = self.startPosition
            let pathX = Int(self.path[num].x)
            let pathY = Int(self.path[num].y)
            if (pathX < columns && pathX >= 0) && (pathY < rows && pathY >= 0) {
                if let mazeRow: Int = maze[pathX][pathY] {
                    if mazeRow == 0 {
                        //temp = self.path[num]
                        bestFit(coor: path[num])
                        //print("maze[pathY][pathX]: \(mazeRow)")
                    } else if mazeRow == 1 {
                        //self.successTil = temp
                        break
                    }
                    
                    
                }
            } else {
                //self.successTil = temp
                break
            }
           
        }
        
        //print("Best fit: \(self.successTil)")
        
    }
    
    private func bestFit(coor: Coordinate) {
        let champ = fitness()
        let vacant = fitness(coor: coor)
        if vacant < champ {
            self.successTil = coor
        }
    }
    
    
    
}
