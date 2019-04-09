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
    case parenthesis = "Круглые"
    case squareBrackets = "Квадратные"
    case brace = "Фигурные"
    case commas = "Ковычки"
    case apostrophes = "Апострофы"
}

/// Счётчик скобочек
class BracketCount {
    private let bracketType: BracketType // тип скобочек
    private var brackets: [Character]
    private var numberOfPairsOfBrackets: Int = 0, numberNoPairOfBrackets: Int = 0 // Количество парных скобок
    private var levt: Int = 0, right: Int = 0

    /// Конструктор класса
    ///
    /// - Parameters:
    ///   - bracket: Тип скобочек
    public init(bracket: BracketType) {
        self.bracketType = bracket
        switch self.bracketType { // В зависимости от перечисленич получаем символы
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
        return self.calculateBrackets(text: try! String.init(contentsOf: URL.init(string: filePath)!)) // возвращаем результат подсчёта скобок в строке
    }

    /// Подсчитать скобки
    ///
    /// - Parameter textString: Строка с текстом
    /// - Returns: Количество Не парных скобок
    public func calculateBrackets(text textString: String) -> Int {
        for c in textString { // перебираем символы
            if c == self.brackets[0] { // если скобка отрывающая
                self.levt += 1 // увиличить количество левых скобок
            } else if c == self.brackets[1] { // если скобка правая
                self.right += 1 // увиличиваем количество правых скобок
                if self.levt == self.right { // если количество скобок сровнялось
                    self.numberOfPairsOfBrackets += 1 // увиличиваем количество парных скобок
                }
            }
        }
        if self.levt == self.right { // если количество скобок сровнялось
            self.numberNoPairOfBrackets = 0 // непарных скобок нет
        } else { // иначе
            self.numberNoPairOfBrackets = self.levt - self.right // иначе возвращаем количество непарных скобок
        }
        return self.numberNoPairOfBrackets
    }

    /// Получить количество парных скобок
    ///
    /// - Returns: количество парных скобок
    public func getNumberOfPairsOfBrackets() -> Int {
        return self.numberOfPairsOfBrackets
    }

    /// Количество левых скобок
    ///
    /// - Returns: количество левых скобок
    public func levtBrackets() -> Int {
        return self.levt
    }

    /// Количество правых скобок
    ///
    /// - Returns: Количество правых скобок
    public func rightBrackets() -> Int {
        return self.right
    }

    public func getNumberNoParBrackets() -> Int {
        return self.numberNoPairOfBrackets
    }

    public func getBracketType() -> String {
        return self.bracketType.rawValue
    }
}
