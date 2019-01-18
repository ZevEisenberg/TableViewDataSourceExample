//
//  ImageCell.swift
//  TableViewExample
//
//  Created by Zev Eisenberg on 1/17/19.
//  Copyright © 2019 Zev Eisenberg. All rights reserved.
//

import Anchorage
import UIKit

class ImageCell: UITableViewCell {

    let photoView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(photoView)

        photoView.edgeAnchors == contentView.edgeAnchors
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
