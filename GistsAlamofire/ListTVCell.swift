//
//  ListTableViewCell.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
   
   // MARK: - Outlets
   @IBOutlet weak var userAvatarImage: UIImageView!
   @IBOutlet weak var gistNameLabel: UILabel!
   @IBOutlet weak var userNameLabel: UILabel!
   
   // MARK: - Property
   var gist: Gist? {
      didSet {
         guard let gist = gist else { return }
         
         let url = URL(string: gist.owner.avatar_url)
         let imageData = try! Data(contentsOf: url!)
         // наполняем строку таблицы полученными значениями
         userAvatarImage.image = UIImage(data: imageData)
         gistNameLabel.text = gist.files.first?.value.filename ?? "No gist name"
         userNameLabel.text = gist.owner.login
      }
   }
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
