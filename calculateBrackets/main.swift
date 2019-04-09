//
//  main.swift
//  calculateBrackets
//
//  Created by Артём Семёнов on 08/04/2019.
//  Copyright © 2019 Артём Семёнов. All rights reserved.
//

import Foundation

let argv = ProcessInfo.processInfo.arguments
let mode = ArgumentParser.init(argumentArray: argv)
if mode.getRuneMode() != .errar {
    var counters: [BracketCount] = []
    var noPars: [Int] = []
    counters.append(BracketCount.init(bracket: .parenthesis)) // круглые скобки
    counters.append(BracketCount.init(bracket: .squareBrackets)) // квадратные скобки
    counters.append(BracketCount.init(bracket: .brace)) // Фигурные скобки
    counters.append(BracketCount.init(bracket: .commas)) // Кавычки
    counters.append(BracketCount.init(bracket: .apostrophes)) // апострофы
    switch mode.getRuneMode() {
    case .file:
        for counter in counters {
            noPars.append(counter.calculateBrackets(puth: argv[2]))
        }

    case .string:
        for counter in counters {
            noPars.append(counter.calculateBrackets(text: argv[2]))
        }

    default:
        print("© Artem Semenov")
    }
    print("Тип       Пары Непарные Левые Правые")
    for counter in counters {
        print("\(counter.getBracketType()) \(counter.getNumberOfPairsOfBrackets()) \(counter.getNumberNoParBrackets()) \(counter.levtBrackets()) \(counter.rightBrackets())")
    }
}
