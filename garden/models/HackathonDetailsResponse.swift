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
    let location_lat: Int?#imageLiteral(resourceName: "simulator_screenshot_7A165787-D360-4F9E-8654-16D6CCF2F224.png")
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
