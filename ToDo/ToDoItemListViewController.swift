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
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        token = toDoItemStore?.itemPublisher.sink(receiveValue: {
            [weak self] items in
           self?.items = items
            self?.update(with: items)
       })
        
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func update(with items: [ToDoItem]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter({false == $0.done}),toSection: .todo)
        snapshot.appendItems(items.filter({$0.done}),toSection: .done)
        dataSource?.apply(snapshot)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ToDoItemListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = items[indexPath.row]
        delegate?.selectToDoItem(self, item: item)
    }
}
