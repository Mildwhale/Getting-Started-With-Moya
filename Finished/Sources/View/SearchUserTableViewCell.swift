//
//  SearchUserTableViewCell.swift
//  The MIT License (MIT)
//
//  Copyright (c) 2020 Kyujin Kim
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import SnapKit
import Kingfisher

final class SearchUserTableViewCell: UITableViewCell {
    private let avatarImageView: UIImageView = UIImageView()
    private let userNameLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        addSubview()
        layout()
        style()
    }
    
    private func addSubview() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
    }
    
    private func layout() {
        avatarImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(8.0)
            $0.width.equalTo(avatarImageView.snp.height).multipliedBy(1 / 1)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(8.0)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func style() {
        avatarImageView.backgroundColor = .lightGray
        avatarImageView.kf.indicatorType = .activity
    }
    
    func configuration(imageUrl: String, userName: String) {
        avatarImageView.kf.setImage(with: URL(string: imageUrl)!)
        userNameLabel.text = userName
    }
}
