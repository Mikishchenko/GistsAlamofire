//
//  SingleGist.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation

// MARK: - Описание структуры данных при запросе gists/gistID

struct SingleGist: Decodable {
   var files: [String: FileName]
   var history: [Commit]
}

struct FileName: Decodable {
   var filename: String
   var content: String
}

struct Commit: Decodable {
   var committed_at: String
   var change_status: ChangeStatus
}

struct ChangeStatus: Decodable {
   var additions: UInt
   var deletions: UInt
}
