//
//  data.swift
//  MMS_LecProject
//
//  Created by prk on 08/12/23.
//

import Foundation
enum CategoryGame: String {
    case adventure = "Adventure"
    case horror = "Horror"
    case puzzle = "Puzzle"
    case sport  = "Sport"
    case FPS = "FPS"
}

struct dataItem{
    var priceProduct: Int
    var titleProduct: String
    var categoryProduct: CategoryGame
    var description: String
    var imageProduct: String
}
