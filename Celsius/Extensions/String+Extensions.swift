//
//  String-Extensions.swift
//  Celsius
//
//  Created by Firat on 27.01.2022.
//

import Foundation

extension String {
    
    func escaped() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
