//
//  EditPickerView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/6.
//

import UIKit

class EditPickerView: UIView {
    // MARK: - 公有属性
    public var data = MineModel()
    public var callBack: ((MineModel) -> ())?
    // MARK: - 私有属性
    
    private var viewType = editType.sex
    private var ageArray=[Int](0 ... 100)
    private var sexArray = ["男", "女"]
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    lazy var pickView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - 公有方法

    public func updateUI(with type: editType, data: MineModel) {
        viewType = type
        self.data = data
        switch viewType {
        case .sex:
            if self.data.sex == "男" {
                pickView.selectRow(0, inComponent: 0, animated: true)
            } else {
                pickView.selectRow(1, inComponent: 0, animated: true)
            }
        case .age:
            pickView.selectRow(Int(self.data.age), inComponent: 0, animated: true)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configDate()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法

    @objc func add() {
        switch viewType {
        case .sex:
            let sex = sexArray[pickView.selectedRow(inComponent: 0)]
            data.sex = sex
            break
        case .age:
            let age=pickView.selectedRow(inComponent: 0)
            data.age=age
            break
        default:
            break
        }
        callBack!(data)
        self.removeFromSuperview()
    }
    
    @objc func cancel() {
        self.removeFromSuperview()
    }

    func configDate() {
        let date = Date()
    }

    func configUI() {
        alpha = 0.7
        backgroundColor = .lightGray
        addSubview(backgroundView)
        backgroundView.addSubview(borderView)
        borderView.addSubview(confirmButton)
        borderView.addSubview(cancelButton)
        backgroundView.addSubview(pickView)

        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(600)
            make.bottom.right.left.equalToSuperview()
        }

        borderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        pickView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(borderView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.right.equalTo(borderView.snp.right).offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}


extension EditPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        switch viewType {
        case .sex:
            label.text = sexArray[row]
        case .age:
            label.text=String(ageArray[row])
        }
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch viewType {
        case .sex:
            return sexArray.count
        case .age:
            return ageArray.count
        }
    }
}
