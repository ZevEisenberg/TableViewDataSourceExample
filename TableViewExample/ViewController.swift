//
//  ViewController.swift
//  TableViewExample
//
//  Created by Zev Eisenberg on 1/17/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import UIKit

enum Item {
    case text(String)
    case image(UIImage)

    var reuseIdentifier: String {
        switch self {
        case .text: return textCellName
        case .image: return imageCellName
        }
    }
}

let imageCellName = "imageCell"
let textCellName = "textCell"

class ViewController: UIViewController {

    let data: [[Item]] = [
        [
            .text("Hello"),
            .text("Boston"),
            .image(#imageLiteral(resourceName: "boston1")),
            ],
        [
            .text("whatever"),
            .image(#imageLiteral(resourceName: "boston3")),
            .image(#imageLiteral(resourceName: "boston2")),
            ]
    ]

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.edgeAnchors == view.edgeAnchors

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ImageCell.self, forCellReuseIdentifier: imageCellName)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: textCellName)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.section][indexPath.item]
        switch item {
        case .image(let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath) as! ImageCell
            cell.photoView.image = image
            return cell
        case .text(let string):
            let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = string
            return cell
        }
    }

}
