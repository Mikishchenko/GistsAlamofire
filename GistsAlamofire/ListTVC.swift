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
var pageNumber = 0

class ListTableViewController: UITableViewController {
   
   override func viewDidLoad() {
      super .viewDidLoad()
      // подгрузка данных в первый раз
      addNextPage(self)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      refresh.attributedTitle = NSAttributedString(string: "Обновление данных ...")
      refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
      // отображаем индикатор обновления
      self.tableView.addSubview(refresh)
   }
   
   // обновление таблицы
   @objc func handleRefresh() {
      DispatchQueue.main.async {
         self.tableView.reloadData()
      }
      refresh.endRefreshing()
   }
   
   @IBAction func addGistsButton(_ sender: UIBarButtonItem) {
      // оставил кнопку на всякий пожарный случай, иногда с первого раза данные не грузились
      addNextPage(self)
   }
   
   // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      print("-> gists.count = \(gistsList.count)")
      return gistsList.count
   }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListsCell",
                                                     for: indexPath) as? ListTableViewCell
         else { return UITableViewCell() }
      cell.gist = gistsList[indexPath.row]
      
      // мой вариант пагинации (самый лаконичный)
      guard indexPath.row == gistsList.count - 1 else { return cell }
         addNextPage(self)
      
      return cell
   }
   
   // MARK: - Table view delegate
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      currentGist = gistsList[indexPath.row]
      // загружаем данные о гисте с заданным id
      requestData(for: (currentGist?.id)!)
   }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 72.0
   }
}

// MARK: - Переход на следующую страницу и активация запроса на получение данных
func addNextPage(_ currentVC: UITableViewController) {
   pageNumber += 1
   print("-> pageNumber = \(pageNumber)")
   // запрашиваем данные для списка gists/public
   requestData(for: "public?page=" + String(pageNumber))
   // отобразить таблицу нужно с небольшой задержкой, чтобы успеть получить данные
   DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
      currentVC.tableView.reloadData()
   })
}
