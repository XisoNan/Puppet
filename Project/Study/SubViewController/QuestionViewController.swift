//
//  ViewController.swift
//  Quizzier
//
//  Created by liyuehang on 2023/11/14.
//

import UIKit
import HandyJSON
import SwiftyJSON
import SnapKit

class QuestionViewController: UIViewController {
    
    var isCompleteAnswer: Bool = false
    
    var puppet_name:String!
    var curIndex:Int=0{
        didSet {
            questionLabel.text = "\(curIndex+1)." + questions[curIndex].title
            self.AButton.setTitle("  A. \(questions[curIndex].options[0].content)", for: .normal)
            self.BButton.setTitle("  B. \(questions[curIndex].options[1].content)", for: .normal)
            self.CButton.setTitle("  C. \(questions[curIndex].options[2].content)", for: .normal)
            self.DButton.setTitle("  D. \(questions[curIndex].options[3].content)", for: .normal)
            if(curIndex==questions.count-1){
                Right.image=UIImage(named:"question_submit")
            }else{
                Right.image=UIImage(systemName:"arrowshape.right.fill")
            }
            ProgressLabel.text="\(curIndex+1)/\(questions.count)"
            if record[curIndex] != "" {
                setOptionButtonColor(record[curIndex])
            } else {
                setOptionButtonColor("")
            }
            if curIndex == questions.count-1 {
                let image: UIImage? = !isCompleteAnswer ? UIImage(named: "question_submit") : nil
                Right.image=image
            } else {
                Right.image=UIImage(systemName: "arrowshape.right.fill")
            }
//            if isCompleteAnswer {
//                answerLabel.text = "答案： " + questions[curIndex].answer.name
//            }
        }
    }
    var record:[String]=[]

    lazy var questionLabel: UILabel={
        let label=UILabel()
        label.numberOfLines=0
        label.textColor = .black
        label.font=UIFont(name:"Arial",size: 17)
        return label
    }()
    
    lazy var AButton: UIButton={
        let button=UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    
    lazy var BButton: UIButton={
        let button=UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    
    lazy var CButton: UIButton={
        let button=UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    
    lazy var DButton: UIButton={
        let button=UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    
    lazy var Left:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var Right:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var ProgressLabel: UILabel={
        let label=UILabel()
        label.font=UIFont(name: "Arial", size: 17)
        return label
    }()
    
    lazy var goadImageView: UIImageView = {
        let imgV = UIImageView(frame: CGRect(x: Int(Width)/2 - 100, y: Int(Height)/2 - 100, width: 200, height: 200))
        imgV.isHidden = true
        return imgV
    }()
    
    lazy var goadLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: Int(Width)/2-150, y: Int(Height)/2+120, width: 200, height: 40))
        label.textAlignment = .center
        label.textColor = .white
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOpacity = 1
        label.font = .systemFont(ofSize: CGFloat(20))
        label.isHidden = true
        return label
    }()
    
    var questions=[Question]()
    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        setUpNav()
        setUpUI()
    }
    
    func handyJSON() {
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "questions", ofType: "json")!))
            guard let jsonString = String(data: data, encoding: .utf8) else { return }
            guard let jsonArray = JSON(parseJSON: jsonString)[puppet_name].array else { return }
            let json=JSON(parseJSON: jsonString)
            questions = jsonArray.map { json -> Question in
                return Question(
                    title: json["title"].stringValue,
                    options: json["options"].array!.map { json -> Option in
                        return Option(name: json["name"].stringValue, content: json["content"].stringValue)
                    },
                    answer: Option(name: json["answer"]["name"].stringValue))
            }
//            completion()
        } catch {
            
        }
}
    
    
    func setUpNav(){
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.title="答题"
            navigation.bar.isHidden=true
            navigation.bar.alpha=0
    //        navigationItem.leftBarButtonItem=Back
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
            navigationItem.leftBarButtonItem = backButton

    }
    @objc func Handleback(){
        navigationController?.popViewController(animated: true)
    }
    
    func setUpUI(){
        self.record=Array(repeating: "", count: self.questions.count)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MuOu_back")!)
        let tap=UITapGestureRecognizer(target: self, action: #selector(TapHandle))
        view.addGestureRecognizer(tap)
        self.view.addSubview(questionLabel)
        self.view.addSubview(AButton)
        self.view.addSubview(BButton)
        self.view.addSubview(CButton)
        self.view.addSubview(DButton)
        self.view.addSubview(ProgressLabel)
        self.view.addSubview(Left)
        self.view.addSubview(Right)
        self.view.addSubview(goadLabel)
        self.view.addSubview(goadImageView)
        goadImageView.image=UIImage(named:puppet_name.prefix(2)+"_left")
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.height.equalTo(112)
            make.left.equalToSuperview().offset(35)
            make.width.equalTo(359)
        }
        AButton.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(89)
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(38)
            make.width.equalTo(321)
        }
        BButton.snp.makeConstraints { make in
            make.top.equalTo(AButton.snp.bottom).offset(31)
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(38)
            make.width.equalTo(321)
        }
        CButton.snp.makeConstraints { make in
            make.top.equalTo(self.BButton.snp.bottom).offset(31)
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(38)
            make.width.equalTo(321)
        }
        DButton.snp.makeConstraints { make in
            make.top.equalTo(self.CButton.snp.bottom).offset(31)
            make.height.equalTo(57)
            make.left.equalToSuperview().offset(38)
            make.width.equalTo(321)
        }
        Left.snp.makeConstraints { make in
            make.top.equalTo(self.DButton.snp.bottom).offset(47)
            make.height.equalTo(67.5)
            make.left.equalToSuperview().offset(11)
            make.width.equalTo(91)
        }
        Right.snp.makeConstraints { make in
            make.top.equalTo(self.DButton.snp.bottom).offset(47)
            make.height.equalTo(67.5)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(91)
        }
        ProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(self.DButton.snp.bottom).offset(47)
            make.height.equalTo(65)
            make.left.equalTo(self.Left.snp.right).offset(50)
            make.width.equalTo(101)
            
        }
        
        Left.image=UIImage(systemName: "arrowshape.left.fill")
        Right.image=UIImage(systemName: "arrowshape.right.fill")
        AButton.layer.cornerRadius=20
        BButton.layer.cornerRadius=20
        CButton.layer.cornerRadius=20
        DButton.layer.cornerRadius=20
        ProgressLabel.textAlignment = .center
        ProgressLabel.text="1/\(questions.count)"
        ProgressLabel.font=UIFont(name: "Arial", size: 22)
        let tapLeft=UITapGestureRecognizer(target: self, action: #selector(LeftHandle))
        let tapRight=UITapGestureRecognizer(target: self, action: #selector(RightHandle))
        Left.isUserInteractionEnabled=true
        Left.addGestureRecognizer(tapLeft)
        Right.isUserInteractionEnabled=true
        Right.addGestureRecognizer(tapRight)
        
        self.questionLabel.text="\(questions[curIndex].title)"
        self.AButton.setTitle("  A. \(questions[curIndex].options[0].content)", for: .normal)
        self.AButton.contentHorizontalAlignment = .left
        self.AButton.contentVerticalAlignment = .center
        self.BButton.setTitle("  B. \(questions[curIndex].options[1].content)", for: .normal)
        self.BButton.contentHorizontalAlignment = .left
        self.BButton.contentVerticalAlignment = .center
        self.CButton.setTitle("  C. \(questions[curIndex].options[2].content)", for: .normal)
        self.CButton.contentHorizontalAlignment = .left
        self.CButton.contentVerticalAlignment = .center
        self.DButton.setTitle("  D. \(questions[curIndex].options[3].content)", for: .normal)
        self.DButton.contentHorizontalAlignment = .left
        self.DButton.contentVerticalAlignment = .center
        //添加交互事件
        AButton.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
       BButton.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
       CButton.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
       DButton.addTarget(self, action: #selector(tapOption(button:)), for: .touchUpInside)
        
    }

    
    
     func updateUI(){
         questionLabel.text=questions[curIndex].title
         self.AButton.setTitle("  A. \(questions[curIndex].options[0].content)", for: .normal)
         self.BButton.setTitle("  B. \(questions[curIndex].options[1].content)", for: .normal)
         self.CButton.setTitle("  C. \(questions[curIndex].options[2].content)", for: .normal)
         self.DButton.setTitle("  D. \(questions[curIndex].options[3].content)", for: .normal)
         if(curIndex==questions.count-1){
             Right.image=UIImage(named:"question_submit")
         }else{
             Right.image=UIImage(systemName:"arrowshape.right.fill")
         }
         ProgressLabel.text="\(curIndex+1)/\(questions.count)"
         if(record[curIndex]=="")
         {
             
         }
    }
    @objc func TapHandle(){
        if(isCompleteAnswer){
            print("finsh")
            navigationController?.popViewController(animated: true)
        }
        else{
            print("unfinish")
            return
        }
    }
    
    
    @objc func LeftHandle(){
        if(curIndex==0){
            
            return
        }
        else{
            curIndex-=1
            curIndex%=questions.count
            updateUI()
        }
    }
    
    @objc func RightHandle(){

        if(curIndex==questions.count-1){
            
            if let _ = record.firstIndex(where: {$0==""}) {
                let alterController = UIAlertController(title: "提示", message: "有题目未完成", preferredStyle: .alert)
                present(alterController, animated: true, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            if(isCheck()){
                //答案全部正确
                isCompleteAnswer=true
                navigationItem.leftBarButtonItem?.isHidden=false
                goadImageView.isHidden = false
                goadImageView.alpha=1
                
                goadImageView.frame = CGRect(x: Width/2, y: Height/2, width: 0, height: 0)
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    goadImageView.frame = CGRect(x: Width/2 - 200, y: Height/2 - 250, width: 200, height: 400)
                }, completion: { [self] _ in
                    goadLabel.text = "获得勋章碎片-" + puppet_name
                    goadLabel.isHidden = false
                    goadLabel.textColor = .black
                    goadLabel.alpha=1
                    self.AButton.alpha=0.1
                    self.BButton.alpha=0.1
                    self.CButton.alpha=0.1
                    self.DButton.alpha=0.1
                    self.Left.alpha=0.1
                    self.Right.alpha=0.1
                    self.questionLabel.alpha=0.1
                    
                })
                isFsh[puppet_name.prefix(2)+"_left"]=true
//                saveBadge(cityName)
            }
            else{
                var message = "\n"
                for i in 0..<record.count {
                    message += "\(i+1).  " + record[i]
                    message += ((record[i]==questions[i].answer.name) ? "  ✅" : ("  ❌")) + "   答案: " + questions[i].answer.name + "\n\n"
                }
                let alterController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
                let quitAction = UIAlertAction(title: "退出答题", style: .default, handler: { [self] _ in
                    navigationController?.popViewController(animated: true)
                })
                let continueAction = UIAlertAction(title: "继续答题", style: .default, handler: { [self] _ in
                    dismiss(animated: true, completion: nil)
                })
                alterController.addAction(quitAction)
                alterController.addAction(continueAction)
                present(alterController, animated: true, completion: nil)
            }
        }
        else{
            curIndex+=1
            curIndex%=questions.count
            updateUI()
        }
    }
    
    func isCheck()->Bool{
        for i in 0..<record.count{
            if ((record[i] == "") || (record[i] != questions[i].answer.name)){
                return false
            }
        }
        return true
    }
    
    
    
}

extension QuestionViewController{
    @objc func tapOption(button:UIButton){
        print("111")
        if let title=button.titleLabel?.text{
            let optionTag=String(title[title.index(title.startIndex,offsetBy: 2)])
            print("\(optionTag)")
            setOptionButtonColor(optionTag)
        }
//        RightHandle()
    }
    
    func setOptionButtonColor(_ optionTag:String){
        var bgColors: [UIColor] = [.white, .white, .white, .white]
        var titleColors: [UIColor] = [.green, .green, .green, .green]
        switch optionTag {
        case "A":
            bgColors[0] = UIColor.orange
            titleColors[0] = .white
            record[curIndex]="A"
        case "B":
            bgColors[1] = UIColor.orange
            titleColors[1] = .white
            record[curIndex]="B"
        case "C":
            bgColors[2] = UIColor.orange
            titleColors[2] = .white
            record[curIndex]="C"
        case "D":
            bgColors[3] = UIColor.orange
            titleColors[3] = .white
            record[curIndex]="D"
        default:
            break
        }
        
        changeOptionButtonColor(AButton, backgroundColor: bgColors[0], titleColor: titleColors[0])
        changeOptionButtonColor(BButton, backgroundColor: bgColors[1], titleColor: titleColors[1])
        changeOptionButtonColor(CButton, backgroundColor: bgColors[2], titleColor: titleColors[2])
        changeOptionButtonColor(DButton, backgroundColor: bgColors[3], titleColor: titleColors[3])
    }
    
    func changeOptionButtonColor(_ button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
    }
}



