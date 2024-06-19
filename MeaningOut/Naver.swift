//
//  Naver.swift
//  MeaningOut
//
//  Created by 여누 on 6/15/24.
//

import UIKit

struct Naver : Decodable{
    let total : Int
    let start : Int
    let display : Int
    var items : [NaverInfo]
}


struct NaverInfo : Decodable{
    let title : String
    let image : String
    let lprice : String
    let mallName : String
    let link : String
    var like : Bool
    
    enum CodingKeys: CodingKey {
        case title
        case image
        case lprice
        case mallName
        case link
        case like
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        self.lprice = try container.decode(String.self, forKey: .lprice)
        self.mallName = try container.decode(String.self, forKey: .mallName)
        self.link = try container.decode(String.self, forKey: .link)
        self.like = false
    }
}
