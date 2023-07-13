//
//  ToDoItemListViewController.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/3/23.
//

import UIKit
import Combine

protocol ToDoListViewControllerProtocol{
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem)
    func addToDoItem(_ viewController: UIViewController)
}

enum Section{
    case todo
    case done
}

class ToDoItemListViewController: UIViewController {
    
    var delegate: ToDoListViewControllerProtocol? = nil
    let dateFormatter = DateFormatter()
    var toDoItemStore: ToDoItemStoreProtocol?
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, ToDoItem>?
    private var items: [ToDoItem] = []
    private var token: AnyCancellable?
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        token = toDoItemStore?.itemPublisher
            .sink(receiveValue: { [weak self] items in
            self?.items = items
            self?.update(with: items)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        token?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = UITableViewDiffableDataSource<Section, ToDoItem>(
        tableView: tableView, cellProvider: { [weak self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
            cell.titleLabel.text = item.title
            cell.locationLabel.text = item.location?.name
            if let timeStamp = item.timeStamp{
                let date = Date(timeIntervalSince1970: timeStamp)
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
                
            }
            return cell
        })
        dateFormatter.dateStyle = .short
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        token = toDoItemStore?.itemPublisher.sink(receiveValue: {
            [weak self] items in
           self?.items = items
            self?.update(with: items)
       })
        
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        navigationItem.rightBarButtonItem = addItem
    }
    @objc func add(_ sender: UIBarButtonItem){
        delegate?.addToDoItem(self)
    }
    private func update(with items: [ToDoItem]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter({false == $0.done}),toSection: .todo)
        snapshot.appendItems(items.filter({$0.done}),toSection: .done)
        dataSource?.apply(snapshot)
    }

}

extension ToDoItemListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item: ToDoItem
        switch indexPath.section{
        case 0:
            let filteredItems = items.filter({!$0.done})
            item = filteredItems[indexPath.row]
        default:
            let filteredItems = items.filter({true == $0.done})
            item = filteredItems[indexPath.row]
            
        }
        
        delegate?.selectToDoItem(self, item: item)
    }
}
