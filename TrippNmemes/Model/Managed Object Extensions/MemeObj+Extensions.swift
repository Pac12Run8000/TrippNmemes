//
//  MemeObj+Extensions.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 8/10/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation
import CoreData

extension MemeObj {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
