//
//  ProgressView.swift
//  Pro_Test-3
//
//  Created by 1234 on 2024/3/21.
//

import UIKit

class ProgressView: UIView {
    lazy var leftP:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var rightP:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var labelP:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "Arial", size: 22)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        addSubview(leftP)
        addSubview(rightP)
        addSubview(labelP)
       
    }

}
