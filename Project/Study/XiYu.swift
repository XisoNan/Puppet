//
//  XiYu.swift
//  Project
//
//  Created by 1234 on 2024/8/17.
//

import UIKit

class XiYu: UIViewController, CAAnimationDelegate {
    
    var img:UIImage?
    var MuXi:UILabel!
    var imageView:UIImageView!
    lazy var medal:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image=UIImage(named: "Medal")
        return imageView
    }()
    
    lazy var Kaiqi:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image=UIImage(named: "开启")
        return imageView
    }()
    
    lazy var Qian:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image=UIImage(named: "Qian")
        return imageView
    }()
    
    lazy var Yu:UILabel={
        let lbl=UILabel()
        lbl.font=UIFont(name: "Arial", size: 20)
        lbl.textColor = .black
        lbl.numberOfLines=0
        return lbl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        view.backgroundColor=UIColor(patternImage: img!)
        imageView=UIImageView(image:UIImage(named: "Xiyu"))
        imageView.frame=CGRect(x: Width/2-100, y: Height/2-250, width: 220, height: 200)
        self.view.addSubview(imageView)
        MuXi=UILabel()
        MuXi.font=UIFont(name: "Arial", size: 40)
        MuXi.textColor = .brown
        MuXi.frame=CGRect(x: 130, y: 330, width: 180, height: 50)

        MuXi.text=MuOuImage[rdm]
        self.view.addSubview(MuXi)
        
        // 创建基本动画对象
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
 
        // 设置动画属性
        fadeInAnimation.fromValue = 0 // 开始的透明度
        fadeInAnimation.toValue = 1 // 结束时的透明度
        fadeInAnimation.duration = 2.8 // 动画持续时间
        fadeInAnimation.delegate = self // 动画代理设置为自己
 
        // 添加动画到label图层
        MuXi.layer.add(fadeInAnimation, forKey: "fadeInAnimation")
        self.view.addSubview(Kaiqi)
        Kaiqi.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(425)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
        }
        let tapKaiqi=UITapGestureRecognizer(target: self, action: #selector(TapHandle))
        Kaiqi.isUserInteractionEnabled=true
        Kaiqi.addGestureRecognizer(tapKaiqi)
        self.view.addSubview(medal)
        medal.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(520)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        medal.isUserInteractionEnabled=true
        let tapToMedal=UITapGestureRecognizer(target: self, action: #selector(TapToMedalHandle))

        medal.addGestureRecognizer(tapToMedal)
    }
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func Handleback(){
        navigationController?.popViewController(animated: false)
        
    }
    @objc func TapToMedalHandle(){
        let MedalVC=MedalViewController()
        MedalVC.img = captureScreenshot(vc: self)!
        MedalVC.modalPresentationStyle = .fullScreen
        MedalVC.hero.isEnabled = true
        self.present(MedalVC, animated: true)
    }
    
    @objc func TapHandle(){
        print(111)
        self.Kaiqi.alpha=0.1
        self.medal.alpha=0.1
        self.MuXi.alpha=0.1
        self.imageView.alpha=0.1
        let prestr=MuOuImage[rdm].index(MuOuImage[rdm].startIndex, offsetBy: 2)
        print(prestr)
        print(type(of:prestr))
//        if(isFsh[prestr+"_left"]!){
//            
//        }
        self.view.addSubview(Qian)
        Qian.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(100)
            
        }
        self.view.addSubview(Yu)
        self.Yu.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(30)
        }
        self.Yu.text=YU[rdm]
    }
}
