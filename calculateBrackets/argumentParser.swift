//
//  argumentParser.swift
//  calculateBrackets
//
//  Created by Артём Семёнов on 08/04/2019.
//  Copyright © 2019 Артём Семёнов. All rights reserved.
//

import Foundation

/// перечисление всех аргументов командной строки, которые будет понимать парсер
///
/// - shortHelpKey: короткий ключ помощи
/// - helpKey: длинный ключ помощи
/// - fileShortKey: короткий ключ для файла
/// - fileKey: длинный ключ для файла
/// - stringShortKey: короткий ключ для строки
/// - stringKey: длинный ключ для строки
enum CLArguments: String {
    case shortHelpKey = "-h"
    case helpKey = "--help"
    case fileShortKey = "-f"
    case fileKey = "--file"
    case stringShortKey = "-s"
    case stringKey = "--string"
}

/// режим работы утилиты
///
/// - help: вывести справку
/// - file: работать с файлом
/// - string: работать со строкой
/// - errar: Ошибка
enum RunMode: String {
    case help
    case file
    case string
    case errar
}

/// Парсер аргументов командной строки
class ArgumentParser {
    /// Режим запуска
    private var runMode: RunMode
    /// Справка по ключам
    public let keyHelp = ["    Справка по ключам",
                                  "    -h | --help — Справка по ключам",
                                  "    -f | --file — Подсчёт скобок в файле",
                                  "    -s | --string — Подсчёт скобок в строке или части текста"]

    /// Конструктор класса
    ///
    /// - Parameter argv: Массив строк аргументов командной строки
    public init(argumentArray argv: [String]) {
        if argv.count == 1 { // если в наборе аргументов только одно значение
            print("Не указаны оргументы запуска") // выводим ругательное сообщениее
            self.runMode = .errar // устанавливаем режим работы ошибка
            self.printKeyHelp() // выводим справку
        } else if let argType = CLArguments(rawValue: argv[1].lowercased()) { // если удалось инициировать перечисление принимаемых аргументов
                switch argType { // перебираем аргументы
                case .helpKey: self.runMode = .help
                case .shortHelpKey: self.runMode = .help
                case .fileKey: self.runMode = .file
                case .fileShortKey: self.runMode = .file
                case .stringKey: self.runMode = .string
                case .stringShortKey: self.runMode = .string
                }
            if (argv.count == 2) && ((self.runMode == RunMode.file) || (self.runMode == RunMode.string)) { // если не указан ещё один аргумент
                print("Не указана строка или путь к файлу") // ругаемся
                self.runMode = .errar // устанавливаем режим работы ошибка
            } else if (argv.count == 2) && (self.runMode == RunMode.help) { // если есть ключ справки
                self.printKeyHelp() // выводим справку
            }
        } else { // Иначе ключ не правильный
            self.runMode = .errar // ругаемся
            print("Не правильный ключ") // устанавливаем ошибку
            self.printKeyHelp()
        }
    }

    /// Метод выводит справку
    private func printKeyHelp() {
        for s in self.keyHelp { // перебираем строки
            print(s) // выводим
        }
    }

    /// Метод возвращает режим работы
    ///
    /// - Returns: режим работы приложения
    public func getRuneMode() -> RunMode {
        let r = self.runMode // получаем режим
        return r // возвращем
    }
}
