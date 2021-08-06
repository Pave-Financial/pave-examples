import Foundation
import UIKit


/// It's a header, containing tittle and subtitle
class ExpendituresSectionHeaderView: UIView {
	
	private lazy var titleLabel: UILabel = {
		let l = UILabel()
		l.numberOfLines = 1
		l.translatesAutoresizingMaskIntoConstraints = false
		l.font = UIFont.systemFont(ofSize: 24, weight: .regular)
		return l
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let l = UILabel()
		l.numberOfLines = 0
		l.translatesAutoresizingMaskIntoConstraints = false
		l.font = UIFont.systemFont(ofSize: 18, weight: .light)
		return l
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(subtitleLabel)
	}
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
	
	override func updateConstraints() {
		let offset = CGFloat(4)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: offset),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: offset),
			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
		])
		
		NSLayoutConstraint.activate([
			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
			subtitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10)
		])
		
		super.updateConstraints()
	}
	
	// MARK: - Public
	
	func setTitle(_ title: String) {
		self.titleLabel.text = title
	}
	
	func setSubtitle(_ title: String) {
		self.subtitleLabel.text = title
	}
}
