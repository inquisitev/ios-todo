//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/8/23.
//

import SwiftUI

protocol ToDoItemInputViewDelegate{
    func addToDoItem(with: ToDoItemData, coordinate: Coordinate?)
}

struct ToDoItemInputView: View {
    
    
    @ObservedObject var data: ToDoItemData
    @State var withDate = false
    let apiClient: APIClientProtocol
    var delegate: ToDoItemInputViewDelegate?
    
    var didAppear: ((Self) -> Void)?
    
    func addToDoItem(){
        if (!data.address.isEmpty){
            apiClient.coordinate(for: data.address, completion: {
                coordinate in
                delegate?.addToDoItem(with: data, coordinate: coordinate)
            })
        }
        else{
            delegate?.addToDoItem(with: data, coordinate: nil)
        }
    }
    
    var body: some View {
        Form{
            SwiftUI.Section{
                TextField("Title", text: $data.title)
                Toggle("Add Date", isOn: $withDate)
                if(withDate){
                    DatePicker("Date", selection: $data.date)
                }
                TextField("Description", text: $data.description)
            }
            SwiftUI.Section{
                TextField("Location", text: $data.locationName)
                TextField("Address", text: $data.address)
            }
            SwiftUI.Section{
                Button( action: addToDoItem, label: { Text("Save")})
            }
            .onAppear{self.didAppear?(self)}
    }}
}

struct ToDoItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemInputView(data: ToDoItemData(), apiClient: APIClient())
    }
}
