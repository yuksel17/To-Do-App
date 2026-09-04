import UIKit

class AddEditTodoViewController: UIViewController {
    
    // Düzenleme modundaysak mevcut görev, yeni görevse nil
    var itemToEdit: TodoItem?
    
    // Kayıt tamamlandığında ana ekrana görevi ileten closure
    var onSave: ((TodoItem) -> Void)?
    
    // MARK: - UI Bileşenleri
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.keyboardDismissMode = .onDrag
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Görev Başlığı *"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Örn: UIKit projesini hazırla"
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notlar"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()
    
    // Teslim tarihi isteğe bağlı: Switch satırı
    let dateSwitchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teslim Tarihi Ekle"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    let dateSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.isOn = false
        return toggle
    }()
    
    let datePickerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true // Başlangıçta kapalı
        return view
    }()
    
    let datePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tarih ve Saat"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let dueDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "tr_TR")
        return picker
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupLayout()
        populateDataIfNeeded()
        
        // Switch değiştiğinde tetiklenecek fonksiyon
        dateSwitch.addTarget(self, action: #selector(dateSwitchChanged), for: .valueChanged)
    }
    
    // MARK: - Navigation Bar Kurulumu
    
    private func setupNavigationBar() {
        title = (itemToEdit == nil) ? "Yeni Görev" : "Görevi Düzenle"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "İptal",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Kaydet",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    // MARK: - Layout Kurulumu (Auto Layout)
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(noteLabel)
        contentView.addSubview(noteTextView)
        
        contentView.addSubview(dateSwitchLabel)
        contentView.addSubview(dateSwitch)
        contentView.addSubview(datePickerContainer)
        
        datePickerContainer.addSubview(datePickerLabel)
        datePickerContainer.addSubview(dueDatePicker)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Başlık
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Not
            noteLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 8),
            noteTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 120),
            
            // Switch Satırı (Teslim Tarihi Ekle)
            dateSwitchLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 24),
            dateSwitchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateSwitch.centerYAnchor.constraint(equalTo: dateSwitchLabel.centerYAnchor),
            dateSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Tarih Seçici Container
            datePickerContainer.topAnchor.constraint(equalTo: dateSwitch.bottomAnchor, constant: 16),
            datePickerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            datePickerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            datePickerContainer.heightAnchor.constraint(equalToConstant: 44),
            datePickerContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            datePickerLabel.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            datePickerLabel.centerYAnchor.constraint(equalTo: datePickerContainer.centerYAnchor),
            
            dueDatePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            dueDatePicker.centerYAnchor.constraint(equalTo: datePickerContainer.centerYAnchor)
        ])
    }
    
    // MARK: - Veri Doldurma
    
    private func populateDataIfNeeded() {
        guard let item = itemToEdit else {
            dateSwitch.isOn = false
            datePickerContainer.isHidden = true
            return
        }
        
        titleTextField.text = item.title
        noteTextView.text = item.note
        
        if let dueDate = item.dueDate {
            dateSwitch.isOn = true
            datePickerContainer.isHidden = false
            dueDatePicker.date = dueDate
        } else {
            dateSwitch.isOn = false
            datePickerContainer.isHidden = true
        }
    }
    
    // MARK: - Aksiyonlar
    
    @objc private func dateSwitchChanged() {
        UIView.animate(withDuration: 0.25) {
            self.datePickerContainer.isHidden = !self.dateSwitch.isOn
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen görev için bir başlık giriniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
            return
        }
        
        let note = noteTextView.text ?? ""
        // Kullanıcı switch'i açtıysa tarihi kaydet, kapalıysa nil bırak
        let dueDate: Date? = dateSwitch.isOn ? dueDatePicker.date : nil
        
        if var existingItem = itemToEdit {
            existingItem.title = title
            existingItem.note = note
            existingItem.dueDate = dueDate
            onSave?(existingItem)
        } else {
            let newItem = TodoItem(title: title, note: note, dueDate: dueDate, isCompleted: false)
            onSave?(newItem)
        }
        
        dismiss(animated: true)
    }
}
