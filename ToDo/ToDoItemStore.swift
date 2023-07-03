//
//  ToDoItemStore.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/3/23.
//

import Foundation
import Combine

class ToDoItemStore{
    
    let fileName: String
    init(fileName: String = "todoitems"){
        self.fileName = fileName
        loadItems()
    }
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    
    private var items: [ToDoItem] = [] {
        didSet {
            itemPublisher.send(items)
        }
    }
    
    func add(_ item: ToDoItem){
        items.append(item)
        saveItems()
    }
    
    func check(_ item: ToDoItem){
        var mutableItem = item
        mutableItem.done = true
        
        if let index = items.firstIndex(of: item){
            items[index] = mutableItem
            saveItems()
        }
    }
    
    private func loadItems(){
        let url = FileManager.default.documentsURL(name: fileName)
        do {
            let data = try Data(contentsOf: url)
            items = try JSONDecoder().decode([ToDoItem].self, from: data)
        }
        catch{
            print("error: \(error)")
        }
        
    }
    
    private func saveItems(){
        let url = FileManager.default.documentsURL(name: fileName)
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        }
        catch{
            print("error: \(error)")
        }
        
    }
}
