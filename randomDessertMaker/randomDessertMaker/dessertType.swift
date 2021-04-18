//
//  dessertType.swift
//  randomDessertMaker
//
//
//

import Foundation

let dessert = ["塔", "切片蛋糕", "整個蛋糕", "杯子蛋糕", "蛋糕捲", "磅蛋糕", "蜜糖吐司", "擠花蛋糕", "甜甜圈"]
let tart = ["切片塔", "圓形塔", "星形塔", "正方塔", "心型塔", "側面塔"]
let sliceCake = ["夾心", "千層", "背面"]
let aCake = ["夾心", "千層", "磅蛋糕"]

let ingredients = ["堅果", "草莓", "藍莓", "葡萄", "柳丁片", "奇異果", "蔓越莓", "櫻桃", "芒果"]
let jam = ["糖霜", "巧克力醬", "草莓醬", "藍莓醬", "果醬", "奶油"]
let cream = ["無", "波浪奶油", "大顆奶油花", "8齒小奶油花", "圓形小奶油花"]

enum type{
    case tart
    case sliceCake
    case cake
    case cupCake
    case swissRoll
    case poundCake
    case puff
    case toast
    case flowerCake
    case donut
        
}


class dessertType {
    
    
    let numberOfIngredients = 3
    
    var randomDessertType : String = ""
    var randomIngredients : String = ""
    var randomIngredientsType : String = ""
    var randomJam : String = ""
    var randomCream : String = ""
    var result: [String] = []
    
    init() {
        result = makeADessert ()
    }

    func makeADessert () -> ([String]) {
        let randomDessert = dessert.randomElement()!
        randomDessertType = randomDessert
        switch randomDessert {
            case "塔":
                randomDessertType += "-\(tart.randomElement()!)"
            case "切片蛋糕":
                randomDessertType += "-\(sliceCake.randomElement()!)"
            case "整個蛋糕":
                randomDessertType += "-\(aCake.randomElement()!)"
            default:
                randomDessertType += ""
        }


        randomIngredientsType = "\(ingredients.randomElement()!)"
        for _ in 1...numberOfIngredients {
            //randomIngredientsType.append(ingredients.randomElement()!)
            randomIngredientsType += "、\(ingredients.randomElement()!)"
        }

        randomJam = jam.randomElement()!
        randomCream = cream.randomElement()!
        
        let randomResult : [String] = [randomDessertType, randomIngredientsType, randomJam, randomCream]
        
        return randomResult

    }
    
    

    
}
