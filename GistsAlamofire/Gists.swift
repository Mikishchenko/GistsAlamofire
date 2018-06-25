//
//  Gists.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation

// MARK: - Описание структуры данных при запросе gists/public

struct Gist: Decodable {
   let id: String
   let owner: Owner
   let files: [String: FileInAll]
}

struct Owner: Decodable {
   let login: String
   let avatar_url: String
}

struct FileInAll: Decodable {
   let filename: String
}
