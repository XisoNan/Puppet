//
//  DrageViewCell.swift
//  Pro_Test-3
//
//  Created by 1234 on 2024/4/29.
//

import UIKit
import SnapKit
class DrageViewCell: UICollectionViewCell {
    
    lazy var select:UIView={
        let view=UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var chLbl:UILabel={
        let label=UILabel()
        label.text="已选择"
        label.textColor = .brown
        label.font=UIFont(name: "Arial", size: 10)
        return label
    }()
    
    lazy var image:UIImageView={
        let img=UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var title:UILabel={
        let title=UILabel()
        title.text=""
        title.textColor = .black
        title.font=UIFont(name: "Arial", size: 17)
        return title
    }()
    
    lazy var loc:UILabel={
        let title=UILabel()
        title.text=""
        title.font=UIFont(name: "Arial", size: 12)
        title.textColor = .gray
        return title
    }()
    
    lazy var time:UILabel={
        let title=UILabel()
        title.text=""
        title.font=UIFont(name: "Arial", size: 12)
        title.textColor = .gray
        return title
    }()
    
    lazy var info:UILabel={
        let title=UILabel()
        title.text=""
        title.font=UIFont(name: "Arial", size: 10)
        title.textColor = .gray
        return title
    }()
    
    override init(frame:CGRect){

        super.init(frame: frame)
        select.addSubview(chLbl)
        self.layer.borderWidth = 1
       addSubview(image)
        addSubview(loc)
        addSubview(title)
        addSubview(time)
        addSubview(info)
        addSubview(select)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(175)
            make.bottom.equalToSuperview().offset(-5)
        }
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(image.snp.right).offset(10)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        loc.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(1)
            make.centerX.equalTo(title)
            make.height.equalTo(19)
            make.left.equalTo(title)
        }
        time.snp.makeConstraints { make in
            make.top.equalTo(loc.snp.bottom).offset(1)
            make.centerX.equalTo(loc)
            make.height.equalTo(19)
            make.left.equalTo(loc)
        }
        info.snp.makeConstraints { make in
            make.top.equalTo(time.snp.bottom).offset(2)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(loc)
        }
        
        select.snp.makeConstraints { make in
            make.top.equalTo(image.snp.top).offset(10)
            make.right.equalTo(image.snp.right).offset(-13)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        chLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
            
        select.layer.cornerRadius = 5
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        select.alpha=0
        chLbl.alpha=0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
