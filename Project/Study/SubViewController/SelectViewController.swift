import UIKit

class SelectViewController: UIViewController {
    
    lazy var backImage:UIImageView={
        let imageView=UIImageView(frame: self.view.frame)
        imageView.image=UIImage(named: "MuOu_back")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        setUpUI()
    }
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func Handleback(){
        navigationController?.popViewController(animated: true)
    }
    
    
    func setUpUI(){
        
        self.view.addSubview(backImage)
        
        let AnswerView=SelectView()
        
        AnswerView.imageView.image=UIImage(named: "答题")
        
        self.view.addSubview(AnswerView)
        AnswerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(180)
            make.width.equalTo(180)
            make.left.equalToSuperview().offset(20)
        }
        
        AnswerView.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        AnswerView.imageView.layer.cornerRadius=32
         
        AnswerView.textLabel.text="木偶问答"
        
        AnswerView.textLabel.snp.makeConstraints { make in
            make.top.equalTo(AnswerView.imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        AnswerView.backgroundColor = .gray
        
        
        let MazeView=SelectView()
        
        self.view.addSubview(MazeView)
        
        MazeView.snp.makeConstraints { make in
            make.centerY.equalTo(AnswerView)
            make.height.equalTo(180)
            make.width.equalTo(180)
            make.left.equalTo(AnswerView.snp.right).offset(14)
        }
        MazeView.imageView.image=UIImage(named: "MazeIcon2")
        
        MazeView.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        MazeView.imageView.layer.cornerRadius=32
         
        MazeView.textLabel.text="木偶奇遇"
        
        MazeView.textLabel.snp.makeConstraints { make in
            make.top.equalTo(AnswerView.imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        MazeView.backgroundColor = .gray
        
        MazeView.layer.cornerRadius=20
        AnswerView.layer.cornerRadius=20
        
        //添加手势
        let TapToQst=UITapGestureRecognizer(target: self, action: #selector(Tap1))
        
        let TapToMaze=UITapGestureRecognizer(target: self, action: #selector(Tap2))
        
        AnswerView.isUserInteractionEnabled=true
        MazeView.isUserInteractionEnabled=true
        
        AnswerView.addGestureRecognizer(TapToQst)
        MazeView.addGestureRecognizer(TapToMaze)
    }
    
    @objc func Tap1(){
        let QuestionVC=QuestionViewController()
        QuestionVC.puppet_name=MuOuImage[cur_index]
        navigationController?.pushViewController(QuestionVC, animated: true)
    }
    
    @objc func Tap2(){
        let MazeVC=GameViewController()
        MazeVC.scene.puppet_name=MuOuImage[cur_index]
        navigationController?.pushViewController(MazeVC, animated: true)
    }

}
