//
//  TableViewCell.swift
//  VideoApp
//
//  Created by Hridayedeep Gupta on 20/09/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    private var titleLabel: UILabel!
    private var rightIcon: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addTitleLabel()
        addImage()
        contentView.backgroundColor = .darkGray
    }

    private func addTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        let top = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        NSLayoutConstraint.activate([top, leading])
    }

    private func addImage() {
        rightIcon = UIImageView()
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightIcon)
        rightIcon.image = UIImage(systemName: "star.fill")
        NSLayoutConstraint.activate([
            rightIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rightIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            rightIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            rightIcon.widthAnchor.constraint(equalToConstant: 25),
            rightIcon.heightAnchor.constraint(equalToConstant: 25),
//            rightIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with viewModel: ViewModel.Video) {
        titleLabel.text = viewModel.title
        //TODO: update icon based on downloaded/ not downloaded
    }
}
