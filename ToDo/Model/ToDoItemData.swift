//
//  ToDoItemData.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/8/23.
//
import Foundation

class ToDoItemData: ObservableObject{
    @Published var title = ""
    @Published var date = Date()
    @Published var description = ""
    @Published var locationName = ""
    @Published var address = ""
}
