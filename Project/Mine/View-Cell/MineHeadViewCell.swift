//
//  MineHeadViewCell.swift
//  Project
//
//  Created by 1234 on 2024/3/10.
//

import UIKit

class MineHeadViewCell: UITableViewCell {
    var cellCallBack:((UIImage) -> ())?
    private lazy var userImg: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        view.image = UIImage(named: "header")
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "小楠"
        label.textColor = UIColor.black
        label.font = UIFont(name: "PingFangSC-Semibold", size: 18)
        return label
    }()
    private lazy var sexIcon: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "年龄: 18"
        label.textColor = UIColor.orange
        return label
    }()
    
    
    
    public func updateUI(with data: MineModel) {
        self.userName.text = data.name
        self.ageLabel.text = "年龄: \(data.age)"
        self.userImg.image = UIImage(contentsOfFile: data.headerImg)
        if data.sex == "女" {
            self.sexIcon.image = UIImage(named: "woman")
        } else {
            self.sexIcon.image = UIImage(named: "man")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(userImg)
        userImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140)
            make.bottom.equalTo(self.snp.centerY).offset(-5)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        addSubview(sexIcon)
        sexIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.right).offset(10)
            make.bottom.equalTo(self.snp.centerY).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        addSubview(ageLabel)
        ageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140)
            make.top.equalTo(self.snp.centerY).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(75)
        }
    }
    
}
