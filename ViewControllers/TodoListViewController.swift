import UIKit

class TodoListViewController: UIViewController {
    
    // Özellikler
    var allTodos: [TodoItem] = []
    var filteredTodos: [TodoItem] = []
    let userDefaultsKey = "SavedTodoList"
    
    // UI Bileşenleri
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Tümü", "Bekleyenler", "Tamamlananlar"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Görevlerde ara..."
        return sc
    }()
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Henüz görev eklenmemiş.\nSağ üstteki '+' butonuna basarak yeni görev oluşturabilirsiniz."
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupNavigationBar()
        setupSearchController()
        setupLayout()
        setupTableView()
        
        loadTodos()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    private func setupNavigationBar() {
        title = "Görevlerim"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupLayout() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
    }
    
    //Veri Saklama
    private func saveTodos() {
        do {
            let data = try JSONEncoder().encode(allTodos)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Hata: \(error.localizedDescription)")
        }
    }
    
    private func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                allTodos = try JSONDecoder().decode([TodoItem].self, from: data)
            } catch {
                allTodos = []
            }
        } else {
            allTodos = [
                TodoItem(title: "iOS UIKit Projesini Tamamla", note: "Auto Layout ve UserDefaults kısımlarını hazırla", dueDate: Date().addingTimeInterval(3600 * 24), isCompleted: false),
                TodoItem(title: "Hızlı Not Al (Tarihsiz)", note: "Bu görevin teslim tarihi yok", dueDate: nil, isCompleted: false),
                TodoItem(title: "Staj Raporunu Hazırla", note: "Swift mimarisini açıkla", dueDate: Date().addingTimeInterval(3600 * 48), isCompleted: true)
            ]
            saveTodos()
        }
        applyFilterAndSearch()
    }
    
    func applyFilterAndSearch() {
        let segmentIndex = segmentedControl.selectedSegmentIndex
        let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        
        var list: [TodoItem] = []
        switch segmentIndex {
        case 1:
            list = allTodos.filter { !$0.isCompleted }
        case 2:
            list = allTodos.filter { $0.isCompleted }
        default:
            list = allTodos
        }
        
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.lowercased().contains(searchText) || $0.note.lowercased().contains(searchText)
            }
        }
        
        filteredTodos = list
        emptyStateLabel.isHidden = !filteredTodos.isEmpty
        tableView.reloadData()
    }
    
    //Aksiyonlar
    @objc private func segmentedControlChanged() {
        applyFilterAndSearch()
    }
    
    @objc private func addButtonTapped() {
        let addVC = AddEditTodoViewController()
        addVC.onSave = { [weak self] newItem in
            guard let self = self else { return }
            self.allTodos.insert(newItem, at: 0)
            self.saveTodos()
            self.applyFilterAndSearch()
        }
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }
    
    private func editTodo(_ item: TodoItem) {
        let editVC = AddEditTodoViewController()
        editVC.itemToEdit = item
        editVC.onSave = { [weak self] updatedItem in
            guard let self = self else { return }
            if let index = self.allTodos.firstIndex(where: { $0.id == updatedItem.id }) {
                self.allTodos[index] = updatedItem
                self.saveTodos()
                self.applyFilterAndSearch()
            }
        }
        let navController = UINavigationController(rootViewController: editVC)
        present(navController, animated: true)
    }
    
    private func toggleTodoCompletion(at index: Int) {
        guard index < filteredTodos.count else { return }
        let item = filteredTodos[index]
        if let originalIndex = allTodos.firstIndex(where: { $0.id == item.id }) {
            allTodos[originalIndex].isCompleted.toggle()
            saveTodos()
            applyFilterAndSearch()
        }
    }
    
    private func deleteTodo(at index: Int) {
        guard index < filteredTodos.count else { return }
        let item = filteredTodos[index]
        if let originalIndex = allTodos.firstIndex(where: { $0.id == item.id }) {
            allTodos.remove(at: originalIndex)
            saveTodos()
            applyFilterAndSearch()
        }
    }
}

// UITableViewDataSource & UITableViewDelegate
extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        
        let item = filteredTodos[indexPath.row]
        cell.configure(with: item)
        
        cell.onToggleComplete = { [weak self] in
            self?.toggleTodoCompletion(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredTodos[indexPath.row]
        editTodo(item)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (_, _, completion) in
            self?.deleteTodo(at: indexPath.row)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//UISearchResultsUpdating
extension TodoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        applyFilterAndSearch()
    }
}
