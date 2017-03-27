//
//  DNA.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation

class DNA {
    
    var mutationLevel: Double
    var genes: [NextStep] = []
    
    init(mutationLevel: Double) {
        self.mutationLevel = mutationLevel
        randomChromosomes()
    }
    
    init(mutationLevel: Double, chromosomes: [NextStep]) {
        self.genes = chromosomes
        self.mutationLevel = mutationLevel
    }
    
    public func mutate() {
        let randChrome = Int.random(range: (0..<genes.count))
        let randNextStep = Int.random(range: (0..<5))
        self.genes[randChrome] = NextStep(rawValue: randNextStep)!
        
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
        
        for _ in 0..<MAX_MOVES {
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
