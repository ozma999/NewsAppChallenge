//
//  NewsDataModel.swift
//  NewsAppChallenge
//
//  Created by Samuel Mejia Guarin on 5/09/18.
//  Copyright © 2018 Samuel Mejia Guarin. All rights reserved.
//
import ObjectMapper
import Foundation

struct NewsDataModel: Mappable {
    var totalResults: Int?
    var articles: [Article]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        totalResults     <- map["totalResults"]
        articles     <- map["articles"]
    }
}

struct Article : Mappable{
    var source: Source?
    var author, title, description, url: String?
    var urlToImage: String?
    var publishedAt: String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        source     <- map["source"]
        author     <- map["author"]
        title     <- map["title"]
        description     <- map["description"]
        url     <- map["url"]
        urlToImage     <- map["urlToImage"]
        publishedAt     <- map["publishedAt"]


    }
}

struct Source:Mappable {
    var id, name: String?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id     <- map["id"]
        name     <- map["name"]


    }
}
