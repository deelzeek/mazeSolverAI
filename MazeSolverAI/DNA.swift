//
//  DNA.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation

class DNA {
    
    var mutationLevel: Int
    var genes: [NextStep] = []
    
    init(mutationLevel: Int) {
        self.mutationLevel = mutationLevel
        randomChromosomes()
    }
    
    init(mutationLevel: Int, chromosomes: [NextStep]) {
        self.genes = chromosomes
        self.mutationLevel = mutationLevel
    }
    
    public func mutate() {
        for n in 0..<genes.count {
            let randChrome = Int.random(range: 0..<1000)
            if randChrome < mutationLevel {
                let randNextStep = Int.random(range: (0..<5))
                self.genes[n] = NextStep(rawValue: randNextStep)!
            }
            
        }
        
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
        
        chromosomes.append(randomChromosome())
        
        for i in 1..<MAX_MOVES {

            let chromo = randomChromosome()
            chromosomes.append(chromo)

        }
        
        self.genes = chromosomes
    }
    
    private func randomChromosome() -> NextStep {
        let random = Int.random(range: Range(0...3))
        
        switch random {
        case 0:
            return NextStep.North
        case 1:
            return NextStep.South
        case 2:
            return NextStep.East
        case 3:
            return NextStep.West
        default:
            return NextStep.Stay
        }
    }

    
    
}
