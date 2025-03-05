//
//  MineViewController.swift
//  Project
//
//  Created by 1234 on 2024/2/7.
//

import UIKit
import SnapKit
import CoreData

let width=UIScreen.main.bounds.width
let height=UIScreen.main.bounds.height
class MineViewController: UIViewController {
    let MineHeadViewCellID="MineHeadViewCellID"
    var MineData = MineModel();//Mine数据
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext//获取上下文
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "header")
        return img
    }()
    
    lazy var tableView:UITableView={
        let tableView=UITableView()
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(MineHeadViewCell.self, forCellReuseIdentifier: MineHeadViewCellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator=false
        tableView.isScrollEnabled=false
        return tableView
    }()
    
    lazy var editButton:UIButton={
       let editButton=UIButton()
       editButton.setTitle("更改信息", for: .normal)
       editButton.tintColor=UIColor.gray
       editButton.layer.cornerRadius=10;
       editButton.setTitleColor(UIColor.gray, for: .normal)
       editButton.titleLabel?.font=UIFont(name: "Arial", size: 12)
       editButton.layer.borderColor=CGColor(red: 0.5, green: 0.5, blue: 0.6, alpha: 1)
       editButton.layer.borderWidth=1.0
       editButton.titleLabel?.textAlignment=NSTextAlignment.center
        editButton.isEnabled=true
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
       return editButton
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartNavUI()
        StartData()
        StartUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        archiveData(data:MineData)
    }
    
    func StartNavUI(){
        navigation.bar.alpha=0
        navigation.bar.isShadowHidden=true
    }
    
    func StartData(){
        MineData=getLocalData()
    }
    
    func StartUI(){
        print(MineData)
        self.view.backgroundColor = .white
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.height.equalTo(270)
            make.top.equalToSuperview().offset(0)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalTo(view.snp.right).offset(-5)
            make.top.equalTo(backgroundImage.snp.bottom).offset(-80)
            make.bottom.equalTo(view.snp.bottom)
        }
        view.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(90)
            make.bottom.equalTo(self.backgroundImage.snp.bottom).offset(-3)
            make.height.equalTo(20)
        }
        if let image=UIImage(contentsOfFile: MineData.headerImg){
            MineData.headerImg=archivImage(image:image,type:"userImage")
        }else{
            let image = UIImage(named: "header")
            MineData.headerImg = archivImage(image: image!, type: "userImage")
        }
    }
 
    
}

extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func getLocalData()-> MineModel{
        let path=NSHomeDirectory().appending("/Documents/user.plist")
        if let data=NSArray(contentsOfFile: path){
            let dic=data[0] as! NSDictionary
            let model=MineModel.deserialize(from:dic, designatedPath: "")!
            return model
        }
        else{
            return MineModel(name:"小楠",age: 18,headerImg: "",sex: "男")
        }
    }
    func archiveData(data:MineModel){
        let dic=NSDictionary(dictionary: data.toJSON()!)
        let path=NSHomeDirectory().appending("/Document/user.plist")
        let arr=NSMutableArray()
        arr.add(dic)
        arr.write(toFile: path, atomically: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: MineHeadViewCellID, for: indexPath) as! MineHeadViewCell
        cell.cellCallBack={image in
            self.MineData.headerImg=archivImage(image: image, type: "headerImage")
        }
        cell.updateUI(with: MineData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func editAction(){
        print("222")
        let vc = EditViewController()
        vc.EditCallBack = { data in
            self.MineData = data
            self.tableView.reloadData()
        }
        vc.updateUI(with: MineData)
        navigationController?.pushViewController(vc, animated: true)
    }
}
