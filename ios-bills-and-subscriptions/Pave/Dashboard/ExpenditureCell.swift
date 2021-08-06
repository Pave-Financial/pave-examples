import UIKit


/// Cell that shows expenditure details. How much money was spend, on what, what's the delta, etc.
class ExpenditureCell: UITableViewCell {
	
	private lazy var cellImageView: UIImageView = {
		let v = UIImageView()
		v.clipsToBounds = true
		v.contentMode = .scaleAspectFit
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .lightGray
		return v
	}()
	
	private lazy var merchantLabel: UILabel = {
		let v = UILabel()
		v.numberOfLines = 1
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	
	private lazy var amountLabel: UILabel = {
		let v = UILabel()
		v.numberOfLines = 1
		v.translatesAutoresizingMaskIntoConstraints = false
		v.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .semibold)
		return v
	}()
	
	private lazy var deltaLabel: InsetLabel = {
		let v = InsetLabel()
		v.numberOfLines = 1
		v.clipsToBounds = true
		v.translatesAutoresizingMaskIntoConstraints = false
		v.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
		return v
	}()
	
	private lazy var detailsLabel: UILabel = {
		let v = UILabel()
		v.numberOfLines = 1
		v.translatesAutoresizingMaskIntoConstraints = false
		v.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
		return v
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(cellImageView)
		contentView.addSubview(merchantLabel)
		contentView.addSubview(deltaLabel)
		contentView.addSubview(amountLabel)
		contentView.addSubview(detailsLabel)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
	
	override func updateConstraints() {
		let inset = CGFloat(16)
		NSLayoutConstraint.activate([
			cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			cellImageView.heightAnchor.constraint(equalToConstant: 50),
			cellImageView.widthAnchor.constraint(equalToConstant: 50),
			cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
		])
		
		NSLayoutConstraint.activate([
			merchantLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: 8),
			merchantLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: inset),
		])
		
		NSLayoutConstraint.activate([
			amountLabel.topAnchor.constraint(equalTo: cellImageView.topAnchor, constant: 0),
			amountLabel.leadingAnchor.constraint(equalTo: merchantLabel.trailingAnchor, constant: 16),
			amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
		])
		
		NSLayoutConstraint.activate([
			deltaLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
			deltaLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -inset),
			deltaLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 0),
		])
		
		NSLayoutConstraint.activate([
			detailsLabel.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 4),
			detailsLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: inset),
		])
		
		super.updateConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.cellImageView.layer.cornerRadius = self.cellImageView.frame.height / 2
		self.deltaLabel.layer.cornerRadius = self.deltaLabel.frame.height / 2
	}
	
	func setImage(_ image: UIImage?) {
		self.cellImageView.image = image
	}
	
	func setMerchant(_ value: String) {
		self.merchantLabel.text = value
	}
	
	func setAmount(_ value: MoneyAmount) {
		self.amountLabel.text = value.string()
	}
	
	func setSubtitle(_ value: String) {
		self.detailsLabel.text = value
	}
	
	func setLastDeltaAmount(_ value: MoneyAmount) {
		if value.amount == 0 {
			self.deltaLabel.text = value.string(showSign: false)
		} else {
			self.deltaLabel.text = value.string(showSign: true)
		}
		
		if value.amount < 0 {
			self.deltaLabel.backgroundColor = UIColor(red: 234.0 / 255.0, green: 244.0 / 255.0, blue: 240 / 255.0, alpha: 1)
			self.deltaLabel.textColor = UIColor(red: 52.0 / 255.0, green: 147.0 / 255.0, blue: 106.0 / 255.0, alpha: 1)
		} else if value.amount == 0 {
			self.deltaLabel.backgroundColor = UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
			self.deltaLabel.textColor = UIColor(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 1)
		} else {
			self.deltaLabel.backgroundColor = UIColor(red: 250.0 / 255.0, green: 239.0 / 255.0, blue: 240 / 255.0, alpha: 1)
			self.deltaLabel.textColor = UIColor(red: 207.0 / 255.0, green: 105.0 / 255.0, blue: 108.0 / 255.0, alpha: 1)
		}
	}
}


