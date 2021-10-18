//
//  User.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

struct User {
    let name: String
    let avatar: UIImage?
    let allPhoto: [UIImage?]
}

var users = [User(name: "А Конор Макгрегор", avatar: UIImage(named: "konor1"), allPhoto: [UIImage(named: "konor1"), UIImage(named: "konor2"), UIImage(named: "konor3")]),
                    User(name: "Б Марк Цукерберг", avatar: UIImage(named: "mark1"), allPhoto: [UIImage(named: "mark1")]),
                    User(name: "В Тим Кук", avatar: UIImage(named: "tim1")!, allPhoto: [UIImage(named: "tim1"), UIImage(named: "tim2")]),
                    User(name: "Г Никола Тесла", avatar: UIImage(named: "tesla1"), allPhoto: [UIImage(named: "tesla1"), UIImage(named: "tesla2")]),
                    User(name: "Д Павел Дуров", avatar: UIImage(named: "durov1"), allPhoto: [UIImage(named: "durov1"), UIImage(named: "durov2")]),
                    User(name: "Е Иван Ургант", avatar: UIImage(named: "ivan1"), allPhoto: [UIImage(named: "ivan1"), UIImage(named: "ivan2")]),
                    User(name: "Ж Илон Маск", avatar: UIImage(named: "mask1"), allPhoto: [UIImage(named: "mask1"), UIImage(named: "mask2"), UIImage(named: "mask3")]),
                    User(name: "З Конор Макгрегор", avatar: UIImage(named: "konor1"), allPhoto: [UIImage(named: "konor1"), UIImage(named: "konor2"), UIImage(named: "konor3")]),
                    User(name: "И Марк Цукерберг", avatar: UIImage(named: "mark1"), allPhoto: [UIImage(named: "mark1")]),
                    User(name: "К Тим Кук", avatar: UIImage(named: "tim1")!, allPhoto: [UIImage(named: "tim1"), UIImage(named: "tim2")]),
                    User(name: "Л Никола Тесла", avatar: UIImage(named: "tesla1"), allPhoto: [UIImage(named: "tesla1"), UIImage(named: "tesla2")]),
                    User(name: "М Павел Дуров", avatar: UIImage(named: "durov1"), allPhoto: [UIImage(named: "durov1"), UIImage(named: "durov2")]),
                    User(name: "Н Иван Ургант", avatar: UIImage(named: "ivan1"), allPhoto: [UIImage(named: "ivan1"), UIImage(named: "ivan2")]),
                    User(name: "О Илон Маск", avatar: UIImage(named: "mask1"), allPhoto: [UIImage(named: "mask1"), UIImage(named: "mask2"), UIImage(named: "mask3")]),
                    User(name: "П Конор Макгрегор", avatar: UIImage(named: "konor1"), allPhoto: [UIImage(named: "konor1"), UIImage(named: "konor2"), UIImage(named: "konor3")]),
                    User(name: "Р Марк Цукерберг", avatar: UIImage(named: "mark1"), allPhoto: [UIImage(named: "mark1")]),
                    User(name: "С Тим Кук", avatar: UIImage(named: "tim1")!, allPhoto: [UIImage(named: "tim1"), UIImage(named: "tim2")]),
                    User(name: "Т Никола Тесла", avatar: UIImage(named: "tesla1"), allPhoto: [UIImage(named: "tesla1"), UIImage(named: "tesla2")]),
                    User(name: "Павел Дуров", avatar: UIImage(named: "durov1"), allPhoto: [UIImage(named: "durov1"), UIImage(named: "durov2")]),
                    User(name: "Иван Ургант", avatar: UIImage(named: "ivan1"), allPhoto: [UIImage(named: "ivan1"), UIImage(named: "ivan2")]),
                    User(name: "Илон Маск", avatar: UIImage(named: "mask1"), allPhoto: [UIImage(named: "mask1"), UIImage(named: "mask2"), UIImage(named: "mask3")])
]

var sortedUsers: [Character: [User]]! {
    return sortedName(arrayUser: users)
}

var litters: [Character]! {
    var keys: [Character] = []
    for i in sortedUsers.keys {
        keys.append(i)
    }
    let sortedKeys = keys.sorted { $0 < $1 }
    return sortedKeys
}

private func sortedName(arrayUser: [User]) -> [Character: [User]]? {
    var newArray: [Character: [User]] = [:]
    for value in arrayUser {
        guard let index = value.name.first else { return nil}
        if newArray[index] == nil {
            newArray[index] = [value]
        } else {
            newArray[index]?.append(value)
        }
    }
    return newArray
}
