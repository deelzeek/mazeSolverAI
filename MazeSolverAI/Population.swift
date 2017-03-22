//
//  Population.swift
//  MazeSolverAI
//
//  Created by Deel Usmani on 21/03/2017.
//  Copyright © 2017 Deel Usmani. All rights reserved.
//

import Foundation


class Population {
    
    var populationAmount: Int
    var population: [Individual] = []
    var mutationLevel: Double
    var fitness = 100
    var bestWithFit : Individual?
    var levelPeaks : LevelPeaks

    
    init(number ofPopulation:Int, mutationLevel: Double, levelPeaks: LevelPeaks) {
        self.populationAmount = ofPopulation
        self.mutationLevel = mutationLevel
        self.levelPeaks = levelPeaks
        
        createPopulation()
    }
    
    
    
    private func createPopulation() {
        for _ in 0..<populationAmount {
            let individium = Individual(mutaLevel: self.mutationLevel , start: levelPeaks.start, dest: levelPeaks.end)
            population.append(individium)
        }
    }
    
    public func start(completion:@escaping ((_ finished: Bool, _ fittest : Individual)->())) {
        for individ in 0..<populationAmount {
            population[individ].checkPath(maze: Labyrinth.sharedInstance.maze)
            let fitn = population[individ].fitness()
            if self.fitness > fitn {
                self.fitness = fitn
                self.bestWithFit = population[individ]
            }
        }
        
        crossover(completion: {
            _ in
            //print("Best of generation: \(self.bestWithFit?.getSuccessTil())")
            completion(true, self.bestWithFit!)
        })
        
    }
    
    func findParent() -> Individual {
        var parent : Individual?
        var rand = Int.random(range: (0..<populationAmount))
        if rand > (populationAmount - 15) {
            rand = rand - 15
        }
        
        var bestFit: Int = 100
        
        for n in 0..<10 {
            let fit = population[rand+n].fitness()
            if bestFit > fit {
                bestFit = fit
                parent = population[rand+n]
            }
        }
        
        return parent!
    }
    //tournament pool
    //roulette pool
    
    public func crossover(completion: ((_ finished:Bool) -> ())) {
        var newPopulation : [Individual] = []
        for _ in 0..<populationAmount {
            let father : Individual = findParent()
            let mother : Individual = findParent()
            
            let fatherChromo = father.getGene()
            let motherChromo = father.getGene()
            
            let split = Int.random(range: (0..<fatherChromo.count))
            var newGene : [NextStep] = []
            
            for index in 0...split {
                newGene.append(fatherChromo[index])
            }
            
            for index in split..<motherChromo.count {
                newGene.append(motherChromo[index])
            }
            
            let offspring: Individual = Individual(newDna: DNA(mutationLevel: 0.1, chromosomes: newGene), start: levelPeaks.start, dest: levelPeaks.end)
            offspring.mutate()
            newPopulation.append(offspring)
            
        }
        self.population.removeAll()
        self.population = newPopulation
        
        completion(true)
    }
    
    public func reproduce() {
        population = []
    }
    
    
}
