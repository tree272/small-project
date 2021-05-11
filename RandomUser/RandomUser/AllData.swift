//
//  AllData.swift
//  RandomUser
//
//  Created by tree on 2021/5/11.
//

import Foundation

struct AllData: Decodable {
    var results: [SingleData]? //其實是一個array
}


struct SingleData:Decodable {
    var name: Name?
    var phone: String?
    var email: String?
    var picture: Picture?
}


struct Name:Decodable {
    var first: String?
    var last: String?
}

struct Picture:Decodable {
    var large: String?
}
