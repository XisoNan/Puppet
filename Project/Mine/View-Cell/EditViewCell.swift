import UIKit
import SnapKit
class EditViewCell: UITableViewCell {
    public func updateUI(with title: String, content: String) {
        let text=title
        let attributes: [NSAttributedString.Key: Any] = [
            .font:UIFont(name: "Arial", size: 22),
            .kern: 2 // 设置字符间距
        ]
         
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        let attributedString2=NSMutableAttributedString(string:content)
        attributedString2.addAttributes(attributes, range: NSRange(location: 0, length: content.count))
        titleLabel.attributedText=attributedString
        contentLabel.attributedText=attributedString2
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 18)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)
        label.alpha = 1
        
        return label
    }()

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 18)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)
        label.alpha = 1
        label.textAlignment = .right
        return label
    }()

    func configUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(22)
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(15)
        }
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(22)
            make.right.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(15)
        }
    }
}
