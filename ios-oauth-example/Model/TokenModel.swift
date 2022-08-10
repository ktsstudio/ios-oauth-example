//
//  TokenModel.swift
//  ios-oauth-example
//
//  Created by Elena Kacharmina on 25.07.2022.
//

import Foundation

struct TokenModel: Codable {
    let access: String?
    let refresh: String?
}
