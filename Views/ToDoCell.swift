
import UIKit

class TodoCell: UITableViewCell {
    
    // Hücrenin yeniden kullanılabilir tanımlayıcısı
    static let identifier = "TodoCell"
    
    // Tamamlama butonuna tıklandığında Controller'a haber veren closure
    var onToggleComplete: (() -> Void)?
    
    // MARK: - UI Bileşenleri
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGreen
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        accessoryType = .disclosureIndicator // Sağa ok işareti ekler
        selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Kurulumu (Auto Layout)
    
    private func setupViews() {
        contentView.addSubview(completeButton)
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(noteLabel)
        textStackView.addArrangedSubview(dateLabel)
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Buton: Sol kenarda ortalanmış
            completeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 36),
            completeButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Metin Yığını: Butonun sağından içeriğin sonuna kadar
            textStackView.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor, constant: 12),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    // MARK: - Yapılandırma (Configure)
    
    func configure(with item: TodoItem) {
        titleLabel.text = item.title
        
        // Not alanı boşsa satırı gizle, doluysa göster
        if item.note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            noteLabel.isHidden = true
        } else {
            noteLabel.isHidden = false
            noteLabel.text = item.note
        }
        
        // Teslim tarihi isteğe bağlıdır; varsa biçimlendirip göster, yoksa gizle
        if let dueDate = item.dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
            dateFormatter.locale = Locale(identifier: "tr_TR")
            dateLabel.isHidden = false
            dateLabel.text = "Son Teslim: " + dateFormatter.string(from: dueDate)
        } else {
            dateLabel.isHidden = true
        }
        
        // Tamamlandı durumuna göre ikon ve üstü çizili metin efekti
        let imageName = item.isCompleted ? "checkmark.circle.fill" : "circle"
        completeButton.setImage(UIImage(systemName: imageName), for: .normal)
        completeButton.tintColor = item.isCompleted ? .systemGreen : .systemGray3
        
        if item.isCompleted {
            let attributeString = NSMutableAttributedString(string: item.title)
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            titleLabel.attributedText = attributeString
            titleLabel.textColor = .tertiaryLabel
        } else {
            titleLabel.attributedText = nil
            titleLabel.text = item.title
            titleLabel.textColor = .label
        }
    }
    
    // MARK: - Aksiyonlar
    
    @objc private func completeButtonTapped() {
        onToggleComplete?()
    }
}
