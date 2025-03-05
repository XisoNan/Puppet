//
//  MuOuViewController.swift
//  Project
//
//  Created by 1234 on 2024/3/28.
//

import UIKit
import SwiftyJSON

class MuOuViewController: UIViewController {
    var img:UIImage!
    var dataFrom:String!
    var puppet_data:JSON!
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.view.frame
        effectView.alpha=0.6
        return effectView
    }()
    
    lazy var ToMore:UIImageView={
        let imageView=UIImageView()
        imageView.image=UIImage(named: "LearnMore")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var MuOuView:UIView={
        let view=UIView()
        view.hero.id="MuOu"
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var MuOu:UIImageView={
        lazy var imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image=UIImage(named: "提线木偶")
        return imageView
    }()
    
    lazy var MuOuName:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "AiDian-QianFengXingKai", size: 25)
        label.textColor = .black
        return label
    }()
    
    lazy var Origin:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "AiDian-QianFengXingKai", size: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var TFrom:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "AiDian-QianFengXingKai", size: 25)
        label.adjustsFontSizeToFitWidth=true
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var TBorn:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "AiDian-QianFengXingKai", size: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var TYear:UILabel={
        let label=UILabel()
        label.font=UIFont(name: "AiDian-QianFengXingKai", size: 25)
        label.textColor = .black
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        HandleData()
        view.backgroundColor=UIColor(patternImage: img)
        //添加模糊效果
        self.view.addSubview(effectView)
        self.view.addSubview(MuOuView)
        MuOuView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.bottom.equalToSuperview().offset(-150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        let tap=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tap)
        setUpUI()
    }
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0
//        navigationItem.leftBarButtonItem=Back
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func Handleback(){
        navigationController?.popViewController(animated: false)
    }
    
    func HandleData(){
        do {
            let Tdata = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "puppet", ofType: "json")!))
            guard let jsonString = String(data: Tdata, encoding: .utf8) else { return }
            let json=JSON(parseJSON: jsonString)
            print(type(of:json[dataFrom]))
            puppet_data=json[dataFrom]
        } catch {
            
        }
    }
    
    
    func setUpUI(){
        let backImage = UIImageView()
//        backImage.frame=self.MuOuView.frame
        backImage.image=UIImage(named: "MuOu_back")
        backImage.contentMode = .scaleAspectFit

        
        MuOuView.addSubview(backImage)
        
        backImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(-20)
        }
        
        MuOuName.text="\(dataFrom!)"
        MuOu.image=UIImage(named: "\(dataFrom!)")
        self.MuOuView.addSubview(MuOuName)
        self.MuOuView.addSubview(MuOu)
        MuOu.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(280)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
        }
        MuOuName.snp.makeConstraints { make in
            make.top.equalTo(self.MuOu.snp.bottom).offset(-90)
            make.height.equalTo(50)
            make.centerX.equalTo(self.MuOu)
            make.width.equalTo(100)
        }
        
        self.MuOuView.addSubview(Origin)
        self.MuOuView.addSubview(TFrom)
        self.MuOuView.addSubview(TBorn)
        self.MuOuView.addSubview(TYear)
        Origin.text="发源地:"
        TBorn.text="诞生年间:"
        TFrom.text="\(puppet_data["TFrom"].stringValue)"
        TYear.text="\(puppet_data["TYear"].stringValue)"
        Origin.snp.makeConstraints { make in
            make.top.equalTo(self.MuOuName.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(calculateLabelWidth(text: Origin.text!, font: Origin.font))
        }
        TBorn.snp.makeConstraints { make in
            make.top.equalTo(self.Origin.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(50)
            make.width.equalTo(calculateLabelWidth(text: TBorn.text!, font: TBorn.font))
        }
        
        TFrom.snp.makeConstraints { make in
            make.centerY.equalTo(self.Origin)
            make.height.equalTo(50)
            make.left.equalTo(self.Origin.snp.right).offset(30)
            make.width.equalTo(calculateLabelWidth(text: TFrom.text!, font: TFrom.font))
        }
        
        
        TYear.snp.makeConstraints { make in
            make.centerY.equalTo(self.TBorn)
            make.height.equalTo(50)
            make.left.equalTo(self.TBorn.snp.right).offset(20)
            make.width.equalTo(calculateLabelWidth(text: TYear.text!, font: TYear.font))
        }
        
        self.MuOuView.addSubview(ToMore)
        
        ToMore.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        ToMore.isUserInteractionEnabled = true
        let TapMore=UITapGestureRecognizer(target: self, action: #selector(TapToInfo))
        ToMore.addGestureRecognizer(TapMore)
        
    }
    
    @objc func tapAction(){
        navigationController?.popViewController(animated: false)
    }
    
    @objc func TapToInfo(){

        print("222")
        let SelectVC=SelectViewController()
        navigationController?.pushViewController(SelectVC, animated: true)
    }
    
}
