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
    var x: Double
    var y: Double
    
    init(_ x: Double,_ y: Double) {
        self.x = x
        self.y = y
    }
}


class Individual {
    
    private let MAX_MOVES = 30
    private var gene : DNA
    private var path: [Coordinate] = []
    private var successTil: Coordinate = Coordinate(0.0,0.0)
    private var startPosition: Coordinate
    private var destination: Coordinate
    
    init(mutaLevel: Double, start: Coordinate, dest: Coordinate) {
        self.gene = DNA(mutaLevel)
        self.startPosition = start
        self.destination = dest
        print("Chromos: \(gene.genes)")
        randomPathCreator()
    }
    
    init(newDna: DNA, start: Coordinate, dest: Coordinate) {
        self.gene = newDna
        self.destination = dest
        self.startPosition = start
        print("Chromos: \(gene.genes)")
        randomPathCreator()
        
    }
    
    public func getPath() -> [Coordinate] {
        return self.path
    }
    
    func setLastSuccess(last: Coordinate) {
        self.successTil = last
    }
    
    public func fitness() -> Int {
        return Int(sqrt(pow(successTil.x - destination.x, 2) + pow(successTil.y - destination.y,2)))
    }
    
    private func randomPathCreator() {
        var pathTemp : [Coordinate] = []
        
        pathTemp.append(startPosition)
        
        for current in 1..<gene.genes.count {
            //let random = Int.random(range: Range(0...3))
            //let yRandom = Int.random(range: (0..3))
            
            var xMove: Double = 0.0
            var yMove: Double = 0.0
            
            switch gene.genes[current] {
            case .North:
                yMove = -1.0
            case .South:
                yMove = 1.0
            case .East:
                xMove = -1.0
            case .West:
                xMove = 1.0
            default:
                break
            }

            let lastX = pathTemp.last?.x
            let lastY = pathTemp.last?.y
            pathTemp.append(Coordinate(lastX! + xMove, lastY! + yMove))
            
        }
        
        self.path = pathTemp
    }
    
    
    
}
