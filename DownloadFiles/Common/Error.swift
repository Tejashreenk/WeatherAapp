//
//  Error.swift
//  downloadFiles
//
//  Created by Tejashree on 23/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//
import UIKit

enum projectError:Error {

    case isEmpty
    case cannotOpen
}

func errorMessage(passedEnum:projectError) -> (String) {
    let title : String!
    
    switch passedEnum {
    case .isEmpty:
        title = "Text Field Should not be Empty"
    case .cannotOpen:
        title = "Cannot download from the URL"
    default:
        title = "Some Error"
    }
    
    return title
}


