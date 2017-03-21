//
//  DNA.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation

class DNA {
    
    let MAX_MOVES = 30
    
    var mutationLevel: Double
    var genes: [NextStep] = []
    
    init(_ mutationLevel: Double) {
        self.mutationLevel = mutationLevel
        randomChromosomes()
    }
    
    public func mutate() {
        
    }
    
    public func toString() -> String {
        return self.genes.description
    }
    
    func getGenes() -> [NextStep]{
        return self.genes
    }
    
    func setGenes(gene: [NextStep]) {
        self.genes = gene
    }
    
    private func randomChromosomes() {
        
        var chromosomes : [NextStep] = []
        
        
        for current in 1...MAX_MOVES {
            let random = Int.random(range: Range(0...3))
            
            switch random {
            case 0:
                chromosomes.append(NextStep.North)
            case 1:
                chromosomes.append(NextStep.South)
            case 2:
                chromosomes.append(NextStep.East)
            case 3:
                chromosomes.append(NextStep.West)
            default:
                chromosomes.append(NextStep.Stay)
            }

            
        }
        
        self.genes = chromosomes
    }

    
    
}
