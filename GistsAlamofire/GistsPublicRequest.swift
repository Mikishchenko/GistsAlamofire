//
//  GistsPublicRequest.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Получение данных по запросу gits/public
public func gistsPublicRequest() {
   let url = URL(string: "https://api.github.com/gists/public")
   Alamofire.request(url!).responseJSON { (response) in
      guard response.result.isSuccess else {
         print("Ошибка при запросе данных\(String(describing: response.result.error))")
         return
      }
      let result = response.data
      do {
         // наполняем массив гистов полученными данными
         gistsList = try JSONDecoder().decode([Gist].self, from: result!)
      } catch {
         print("ERROR!")
      }
   }
}
