//
//  SelectView.swift
//  Project
//
//  Created by 1234 on 2024/4/10.
//

import UIKit

class SelectView: UIView {

    lazy var imageView:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var textLabel:UILabel={
        let text=UILabel()
        text.textColor = .white
        text.font=UIFont(name: "Arial", size: 20)
        return text
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
        addSubview(imageView)
        addSubview(textLabel)

    }

}
