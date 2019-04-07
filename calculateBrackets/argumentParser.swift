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
enum ranMode {
    case help
    case file
    case string
}
