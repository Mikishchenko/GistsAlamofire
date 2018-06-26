//
//  CommitTableViewCell.swift
//  GistsAlamofire
//
//  Created by Владимир Микищенко on 23.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
   
   // MARK: - Outlets
   @IBOutlet weak var commitsDateLabel: UILabel!
   @IBOutlet weak var additionsLabel: UILabel!
   @IBOutlet weak var deletionsLabel: UILabel!
   
   // MARK: - Property
   var commit: Commit? {
      didSet {
         guard let commit = commit else { return }
         // конвертирование полученной даты из String в Date
         let dateFormatter = ISO8601DateFormatter()
         guard let newDate = dateFormatter.date(from: commit.committed_at)
            else { return print("Неудача с конвертированием даты коммита")}

         commitsDateLabel.text = String(describing: newDate)
         additionsLabel.text = String(describing: commit.change_status.additions)
         deletionsLabel.text = String(describing: commit.change_status.deletions)
      }
   }
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
