//
//  HackatonDetailsResponse.swift
//  template
//
//  Created by Михаил Исаченко on 29.05.2021.
//

import Foundation

//struct HackathonDetailsResponce: Codable {
//    let hacks: HackResponse
//}

struct HackathonDetailsResponce: Codable {
    let hacks: [Hack]
}

struct Hack: Codable {
    let id: Int
    let name: String?
    let description: String?
    let start_date: String?
    let end_date: String?
    
    let image: String?
    let url: String?
    let location_lon: Int?
    let location_lat: Int?
    let location: Location?
    
    let sponsors: [Sponsor]
    let tags: [Tag]
}
struct Location: Codable {
    let id: Int
    let city: String
    
    
}
struct Sponsor: Codable {
    let id: Int
    let name: String
    let link: String
    let image: String
}
struct Tag: Codable {
    let id: Int
    let name: String
    
}
