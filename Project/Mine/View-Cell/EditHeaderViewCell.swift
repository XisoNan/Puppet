//
//  EditHeaderViewCell.swift
//  Project
//
//  Created by 1234 on 2024/3/6.
//

import UIKit

class EditHeaderViewCell: UITableViewCell {
    public func updateUI(with title: String, content: String) {
        let text=title
        let attributes: [NSAttributedString.Key: Any] = [
            .font:UIFont(name: "Arial", size: 22),
            .kern: 2 // 设置字符间距
        ]
         
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
         
        titleLabel.attributedText=attributedString
        contentImgView.image = UIImage(named: content)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 16)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)
        label.alpha = 1
        return label
    }()
    
    lazy var contentImgView:UIImageView={
        let imgview=UIImageView()
        imgview.contentMode = .scaleAspectFill
        imgview.clipsToBounds=true
        return imgview
    }()
    
    func configUI(){
        addSubview(titleLabel)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(22)
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(15)
        }
        addSubview(contentImgView)
        contentImgView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(64)
            make.right.equalToSuperview().offset(-70)
            make.top.equalToSuperview().offset(0)
        }
        contentImgView.layer.cornerRadius=32
    }
}
