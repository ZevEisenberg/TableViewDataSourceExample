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
    case action(title: String, action: () -> Void)

    var reuseIdentifier: String {
        switch self {
        case .text: return textCellName
        case .image: return imageCellName
        case .action: return actionCellName
        }
    }
}

let imageCellName = "imageCell"
let textCellName = "textCell"
let actionCellName = "actionCell"

struct Section: ListSection {
    let title: String
    let items: [Item]
}

class ViewController: UIViewController {

    lazy var dataSource = ListDataSource<Section>(sections: [
        Section(
            title: "Section 1",
            items: [
                .text("Hello"),
                .text("Boston"),
                .image(#imageLiteral(resourceName: "boston1")),
                .action(title: "tap me!", action: { [weak self] in
                    let alert = UIAlertController(title: "you tapped me!", message: "yaaaay", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                })
                ]),
        Section(
            title: "Section B",
            items: [
                .text("whatever"),
                .image(#imageLiteral(resourceName: "boston3")),
                .image(#imageLiteral(resourceName: "boston2")),
                ])
        ]
    )

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.edgeAnchors == view.safeAreaLayoutGuide.edgeAnchors

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ImageCell.self, forCellReuseIdentifier: imageCellName)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: textCellName)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: actionCellName)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath]
        switch item {
        case .image(let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath) as! ImageCell
            cell.photoView.image = image
            return cell
        case .text(let string):
            let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = string
            return cell
        case .action(let string, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = string
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath]
        if case .action(_, let action) = item {
            action()
        }
    }

}
