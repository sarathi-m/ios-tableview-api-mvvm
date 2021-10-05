//
//  Model.swift
//  TestList
//
//  Created by Parth Sarathi on 7/12/21.
//

import Foundation

// MARK: - UserElement
struct User: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
    /*
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, address, phone, website, company
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id  = try values.decodeIfPresent(Int.self, forKey: .id)
        name  = try values.decodeIfPresent(String.self, forKey: .name)
        username  = try values.decodeIfPresent(String.self, forKey: .username)
        email  = try values.decodeIfPresent(String.self, forKey: .email)
        address  = try values.decodeIfPresent(Address.self, forKey: .address)
        phone  = try values.decodeIfPresent(String.self, forKey: .phone)
        website  = try values.decodeIfPresent(String.self, forKey: .name)
        company  = try values.decodeIfPresent(Company.self, forKey: .company)
    }
    */
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias Users = [User]
