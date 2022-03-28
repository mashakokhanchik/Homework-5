//
//  UsersData.swift
//  Homework-5.1
//
//  Created by Мария Коханчик on 28.03.2022.
//

import Foundation

struct UsersData: Codable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
}

struct Address: Codable {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo

}

struct Company: Codable {
    
    let name: String
    let catchPhrase: String
    let bs: String
    
}

struct Geo: Codable {
    
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
    
}
