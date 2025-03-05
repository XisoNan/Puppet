

import SnapKit
import UIKit

class EditViewController: UIViewController{
    var EditCallBack:((MineModel)->Void)?
    var MineData=MineModel()
    private let editHeadCellID = "editHeadCell"
    private let editBodyCellID = "editBodyCell"
    private var UserImage: UIImage?
     lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.white
        tableview.register(EditHeaderViewCell.classForCoder(), forCellReuseIdentifier: editHeadCellID)
        tableview.register(EditViewCell.classForCoder(), forCellReuseIdentifier: editBodyCellID)
        return tableview
    }()
    
    private lazy var imagePickController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        return controller
    }()
    
    public func updateUI(with data:MineModel){
        self.MineData=data
        UserImage=UIImage(contentsOfFile: MineData.headerImg)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        EditCallBack!(MineData)
    }
    
    
    private func configUI() {
        self.view.backgroundColor  = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Height)
        }
    }
    
    lazy var alertController: UIAlertController = {
        let alert=UIAlertController(title: "修改昵称", message: nil, preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.placeholder="请修改你的昵称"
        }
        let cancel=UIAlertAction(title:"取消",style: .cancel,handler: nil)
        let Ok=UIAlertAction(title: "确认修改", style: .default) { action in
            if let textField=alert.textFields?.first{
                self.MineData.name=textField.text ?? self.MineData.name
                self.tableView.reloadData()
            }
        }
        alert.addAction(cancel)
        alert.addAction(Ok)
        return alert
            
    }()
    
    func configNavbar(){
        navigation.bar.backgroundColor = UIColor.white
        navigation.bar.alpha = 1
        navigation.item.title = "编辑资料"
    }
    
    private func pick(with type:editType){
        let pickView = EditPickerView()
        pickView.updateUI(with: type, data: self.MineData)
        view.addSubview(pickView)
        pickView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        pickView.callBack = { mine in
            self.MineData = mine
            self.tableView.reloadData()
        }
    }
    
}

extension EditViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell=tableView.dequeueReusableCell(withIdentifier: editHeadCellID, for: indexPath) as! EditHeaderViewCell
            cell.updateUI(with: "头像", content: self.MineData.headerImg)
            cell.accessoryType = .disclosureIndicator
            cell.contentImgView.layer.cornerRadius=32
            return cell
        case 1:
            let cell=tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditViewCell
            cell.updateUI(with: "昵称", content: self.MineData.name)
            cell.accessoryType = .disclosureIndicator
            return cell
        case 2:
            let cell=tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditViewCell
            cell.updateUI(with: "性别", content: self.MineData.sex)
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            let cell=tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditViewCell
            cell.updateUI(with: "年龄", content: String(self.MineData.age))
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            imagePickController.sourceType = .photoLibrary
            present(imagePickController,animated: true)
            tableView.reloadData()
            break
        case 1:
            present(alertController,animated: true,completion: nil)
            alertController.textFields?.first?.text=""//每次选择都会清空上一次field保存的内容
            break
        case 2:
            pick(with: .sex)
            break
        case 3:
            pick(with: .age)
            break
        default:
            break
        }
    }

}

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        UserImage = info[.originalImage] as? UIImage
        tableView.reloadData()
        dismiss(animated: true) {
            self.MineData.headerImg = archivImage(image: self.UserImage!, type: "header")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
    
