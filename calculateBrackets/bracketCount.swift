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
    case parenthesis = "()"
    case squareBrackets = "[]"
    case brace = "{}}"
    case commas = "\"\""
    case apostrophes = "\'\'"
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
    public func calculateBrackets(puth filePath: String) -> Int? {
        if let urlPath = URL.init(string: filePath) {
            let fileName = urlPath.pathComponents.last!
            let nameAndExstention = fileName.split(separator: ".")
            var derPath = urlPath.path
            let ins = fileName.indices
            let range = derPath.index(derPath.endIndex, offsetBy: -ins.count)..<derPath.endIndex
            derPath.removeSubrange(range)
            if let bundle = Bundle.init(path: derPath) {
            if let newURL = bundle.url(forResource: String(nameAndExstention[0]), withExtension: String(nameAndExstention[1])) {
            let str = try! String.init(contentsOf: newURL)
            return self.calculateBrackets(text: str) // возвращаем результат подсчёта скобок в строке
                } else {
                return nil
            }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    /// Подсчитать скобки
    ///
    /// - Parameter textString: Строка с текстом
    /// - Returns: Количество Не парных скобок
    public func calculateBrackets(text textString: String) -> Int {
        for c in textString { // перебираем символы
            if self.brackets[0] == self.brackets[1] {
                if c == self.brackets[0] {
                    self.levt += 1
                }
            } else if c == self.brackets[0] { // если скобка отрывающая
                self.levt += 1 // увиличить количество левых скобок
            } else if c == self.brackets[1] { // если скобка правая
                self.right += 1 // увиличиваем количество правых скобок
                if self.levt == self.right { // если количество скобок сровнялось
                    self.numberOfPairsOfBrackets += 1 // увиличиваем количество парных скобок
                }
            }
        }
        if self.brackets[0] == self.brackets[1] {
            self.numberOfPairsOfBrackets = self.levt / 2
            self.right = self.numberOfPairsOfBrackets
            self.levt -= self.right
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
