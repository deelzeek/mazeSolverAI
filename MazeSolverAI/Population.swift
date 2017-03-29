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
    var mutationLevel: Int
    var fitness: Float = 100.0
    var worstFitness: Float = 0.0
    var bestWithFit : Individual?
    var worstWithFit: Individual?
    var startPos: Coordinate!
    var endPos: Coordinate!
    var average: [Int] = []
    var mazeCurrent: Array<Array<Int>>!

    
    init(number ofPopulation:Int, mutationLevel: Int, startPos: Coordinate, endPos: Coordinate, maze: Array<Array<Int>>) {
        self.populationAmount = ofPopulation
        self.mutationLevel = mutationLevel
        self.startPos = startPos
        self.endPos = endPos
        self.mazeCurrent = maze
        createPopulation()
    }
    
    deinit {
        mazeCurrent.removeAll()
        population.removeAll()
    }
    
    
    
    private func createPopulation() {
        for _ in 0..<populationAmount {
            let individium = Individual(mutaLevel: self.mutationLevel , start: self.startPos, dest: self.endPos)
            population.append(individium)
        }
    }
    
    public func start(_ completion:@escaping ((_ finished: Bool, _ fittest : Individual, _ bestFitness: Float, _ worstFitness: Float)->())) {


        for individ in 0..<populationAmount {
            population[individ].checkPath(maze: mazeCurrent!)
            //let fitn = population[individ].getStepsAchieved()
            let fitn = population[individ].fitness()
            //self.average.append(fitn)
            if self.fitness > fitn {
                self.fitness = fitn
                self.bestWithFit = population[individ]
            }
            
            if self.worstFitness <= fitn {
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
        if rand > (populationAmount - FIND_PARENT_LESS) {
            rand = rand - FIND_PARENT_LESS
        }
        
        var bestFit: Float = 100.0
        
        //var mostSteps: Int = 0
        
        for n in 0..<AMOUNT_OF_CANDITS_FOR_PARENT {
            let distanceToDest = population[rand+n].fitness()
            let step = Float(population[rand+n].getStepsAchieved())
            
            if bestFit > distanceToDest {
                bestFit = distanceToDest
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
            
            for index in 0..<split {
                newGene.append(fatherChromo[index])
            }
            
            for index in split..<motherChromo.count {
                newGene.append(motherChromo[index])
            }
            
            let offspring: Individual = Individual(newDna: DNA(mutationLevel: self.mutationLevel, chromosomes: newGene), start:  startPos, dest: endPos)
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
