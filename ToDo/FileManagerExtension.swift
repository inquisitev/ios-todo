//
//  FileManagerExtension.swift
//  ToDo
//
//  Created by Trevor  Keegan on 7/3/23.
//

import Foundation

extension FileManager{
    func documentsURL(name: String) -> URL{
        guard let documentsURL = urls(for: .documentDirectory, in: .userDomainMask).first else{
            fatalError()
        }
        return documentsURL.appendingPathExtension(name)
    }
}
