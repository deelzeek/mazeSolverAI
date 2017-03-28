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
        for n in 0..<genes.count {
            let randChrome = Int.random(range: 0..<1000)
            if randChrome < 10 {
                let randNextStep = Int.random(range: (0..<5))
                self.genes[n] = NextStep(rawValue: randNextStep)!
                //print("MUTANT KURWA")
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
//            let random = Int.random(range: Range(0...3))
//            
//            switch random {
//            case 0:
//                chromosomes.append(NextStep.North)
//            case 1:
//                chromosomes.append(NextStep.South)
//            case 2:
//                chromosomes.append(NextStep.East)
//            case 3:
//                chromosomes.append(NextStep.West)
//            default:
//                chromosomes.append(NextStep.Stay)
//            }
            let chromo = randomChromosome()
            chromosomes.append(chromo)
            
//            switch chromo {
//            case NextStep.North:
//                
//                if chromosomes[i-1] == NextStep.South {
//                    chromosomes.append(NextStep.South)
//                } else {
//                    chromosomes.append(chromo)
//                }
//            case NextStep.South:
//                
//                if chromosomes[i-1] == NextStep.North {
//                    chromosomes.append(NextStep.North)
//                } else {
//                    chromosomes.append(chromo)
//                }
//            case NextStep.East:
//                
//                if chromosomes[i-1] == NextStep.West {
//                    chromosomes.append(NextStep.West)
//                } else {
//                    chromosomes.append(chromo)
//                }
//            case NextStep.West:
//                
//                if chromosomes[i-1] == NextStep.East {
//                    chromosomes.append(NextStep.East)
//                } else {
//                    chromosomes.append(chromo)
//                }
//            default:
//                
//                chromosomes.append(chromo)
//            }
            
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
