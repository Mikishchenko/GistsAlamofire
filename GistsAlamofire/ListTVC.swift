//
//  ListTableViewController.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

var gistsList = [Gist]()
var currentGist: Gist?
var refresh = UIRefreshControl()

class ListTableViewController: UITableViewController {
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      refresh.attributedTitle = NSAttributedString(string: "Обновление данных ...")
      refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
      // отображаем индикатор обновления
      self.tableView.addSubview(refresh)
      // запрашиваем данные для списка gists/public
      gistsPublicRequest()
      // отобразить таблицу нужно с небольшой задержкой, чтобы успеть получить данные
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
         self.tableView.reloadData()
      })
   }
   
   // обновление таблицы
   @objc func handleRefresh() {
      DispatchQueue.main.async {
         self.tableView.reloadData()
      }
      refresh.endRefreshing()
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return gistsList.count
   }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListsCell",
                                                     for: indexPath) as? ListTableViewCell
         else { return UITableViewCell() }
      cell.gist = gistsList[indexPath.row]
      return cell
   }
   
   // MARK: - Table view delegate
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      currentGist = gistsList[indexPath.row]
      // загружаем данные о гисте с заданным id
      singleGistRequest((currentGist?.id)!)
   }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 72.0
   }
}
