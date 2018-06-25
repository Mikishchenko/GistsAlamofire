//
//  RequestData.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 24.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation
import Alamofire

var currentContent = ""
var commitsList = [Commit]()

// MARK: - Получение данных по запросу gits/gistID
public func requestData(for urlEnding: String) {

   let url = URL(string: "https://api.github.com/gists/" + urlEnding)
   Alamofire.request(url!).responseJSON { (response) in
      guard response.result.isSuccess else {
         print("Ошибка при запросе данных\(String(describing: response.result.error))")
         return
      }
      let result = response.data
      do {
         switch urlEnding {
         case "public":
            gistsList = try JSONDecoder().decode([Gist].self, from: result!)
         case currentGist?.id:
            // очищаем массив комитов (для каждого нового гиста он должен быть пуст)
            commitsList.removeAll()
            let singleGist = try JSONDecoder().decode(SingleGist.self, from: result!)
            // получение текущего контента
            currentContent = singleGist.files.first?.value.content ??
            "Sorry ...\n\nLine is busy now.\n\nPlease go to GISTS LIST\nand comeback to this gist."
            // заполняем массив коммитов
            commitsList = singleGist.history
         default: break
         }
      } catch {
         print("ERROR!")
      }
   }
}
