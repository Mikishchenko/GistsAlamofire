//
//  DetailsViewController.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 25.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
   
   // MARK: - Outlets
   @IBOutlet weak var userAvatarImage: UIImageView!
   @IBOutlet weak var gistNameLabel: UILabel!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var gistContentText: UITextView!
   @IBOutlet weak var commitsTableView: UITableView!
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      // немного изменяем вид некоторых элементов
      someCorrectObject(userAvatarImage)
      someCorrectObject(gistContentText)
      someCorrectObject(commitsTableView)
      // отображение информации о текущем гисте
      let url = URL(string: (currentGist?.owner.avatar_url)!)
      let imageData = try! Data(contentsOf: url!)
      userAvatarImage.image = UIImage(data: imageData)
      gistNameLabel.text = currentGist?.files.first?.value.filename ?? "No gist name"
      userNameLabel.text = currentGist?.owner.login
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
         self.gistContentText.text = currentContent
      })
   }
}

// MARK: - Расширяем DetailsViewController, для возможности поддерживать tableview
extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
   // Table view data source
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      DispatchQueue.main.async {
         tableView.reloadData()
      }
      return commitsList.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommitsCell",
                                                     for: indexPath) as? CommitTableViewCell
         else { return UITableViewCell() }
      cell.commit = commitsList[indexPath.row]
      return cell
   }
   // Table view delegate
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 30.0
   }
}

// MARK: - Небольшие улучшения внешнего вида
func someCorrectObject(_ object: UIView) {
   object.layer.cornerRadius = 3
   object.layer.borderWidth = 1
   object.layer.borderColor = UIColor.black.cgColor
}
