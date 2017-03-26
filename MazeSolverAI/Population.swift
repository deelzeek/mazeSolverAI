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
    var worstFitness = 0
    var bestWithFit : Individual?
    var worstWithFit: Individual?
    var levelPeaks : LevelPeaks
    var level: MazeLevels?
    var average: [Int] = []

    
    init(number ofPopulation:Int, mutationLevel: Double, levelPeaks: LevelPeaks, level: MazeLevels) {
        self.populationAmount = ofPopulation
        self.mutationLevel = mutationLevel
        self.levelPeaks = levelPeaks
        self.level = level
        
        createPopulation()
    }
    
    
    
    private func createPopulation() {
        for _ in 0..<populationAmount {
            let individium = Individual(mutaLevel: self.mutationLevel , start: levelPeaks.start, dest: levelPeaks.end)
            population.append(individium)
        }
    }
    
    public func start(completion:@escaping ((_ finished: Bool, _ fittest : Individual, _ bestFitness: Int, _ worstFitness: Int)->())) {
        var mazeCurrent = Array<Array<Int>>()
        
        switch self.level! {
        case .Level1:
            mazeCurrent = Labyrinth.sharedInstanceLevel1.maze
        case .Level2:
            mazeCurrent = Labyrinth.sharedInstanceLevel2.maze
        case .Level3:
            mazeCurrent = Labyrinth.sharedInstanceLevel3.maze
        default:
            break
        }
        

        for individ in 0..<populationAmount {
            population[individ].checkPath(maze: mazeCurrent)
            let fitn = population[individ].fitness()
            //self.average.append(fitn)
            if self.fitness > fitn {
                self.fitness = fitn
                self.bestWithFit = population[individ]
            }
            
            if self.worstFitness < fitn {
                self.worstFitness = fitn
                //self.worstWithFit = population[individ]
            }
        }
        
        crossover(completion: {
            _ in
            completion(true, self.bestWithFit!, self.fitness, self.worstFitness)
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

    public func crossover(completion: ((_ finished:Bool) -> ())) {
        var newPopulation : [Individual] = []
        for _ in 0..<populationAmount {
            let father : Individual = findParent()
            let mother : Individual = findParent()
            
            let fatherChromo = father.getGene()
            let motherChromo = mother.getGene()
            
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
