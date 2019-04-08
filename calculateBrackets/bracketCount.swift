//
//  bracketCount.swift
//  calculateBrackets
//
//  Created by Артём Семёнов on 08/04/2019.
//  Copyright © 2019 Артём Семёнов. All rights reserved.
//

import Foundation

/// типы скобок
///
/// - parenthesis: круглые скобки
/// - squareBrackets: квадратные скобки
/// - brace: фигурные скобки
/// - commas: кавычки
/// - apostrophes: апострофы
enum BracketType: String {
    case parenthesis
    case squareBrackets
    case brace
    case commas
    case apostrophes
}

/// Счётчик скобочек
class BracketCount {
    private let bracketType: BracketType // тип скобочек
    private var brackets: [Character]
    private var numberOfPairsOfBrackets: Int = 0 // Количество парных скобок

    /// Конструктор класса
    ///
    /// - Parameters:
    ///   - bracket: Тип скобочек
    public init(bracket: BracketType) {
        self.bracketType = bracket
        switch self.bracketType {
        case .parenthesis:
            self.brackets = ["(", ")"]

        case .squareBrackets:
            self.brackets = ["[", "]"]

        case .brace:
            self.brackets = ["{", "}"]

        case .commas:
            self.brackets = ["\"", "\""]

        case .apostrophes:
            self.brackets = ["\'", "\'"]
        }
    }

    /// Подсчитать скобки
    ///
    /// - Parameter filePath: путь к файлу
    /// - Returns: Количество не парных скобок
    public func calculateBrackets(puth filePath: String) -> Int {
        return self.calculateBrackets(text: try! String.init(contentsOf: URL.init(string: filePath)!))
    }

    /// Подсчитать скобки
    ///
    /// - Parameter textString: Строка с текстом
    /// - Returns: Количество Не парных скобок
    public func calculateBrackets(text textString: String) -> Int {
        var noParBrackets:  Int = 0
        for c in textString {
            if c == self.brackets[0] {
                noParBrackets += 1
                if noParBrackets == 0 {
                    self.numberOfPairsOfBrackets += 1
                }
            } else if c == self.brackets[1] {
                noParBrackets -= 1
                if noParBrackets == 0 {
                    self.numberOfPairsOfBrackets += 1
                }
            }
        }
        return noParBrackets
    }

    /// Получить количество парных скобок
    ///
    /// - Returns: количество парных скобок
    private func getNumberOfPairsOfBrackets() -> Int {
        return self.numberOfPairsOfBrackets
    }
}
