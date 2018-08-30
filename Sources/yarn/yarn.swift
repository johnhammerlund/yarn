//
//  yarn.swift
//  yarn
//
//  Created by John Hammerlund on 8/30/18.
//  Copyright © 2018 John Hammerlund. All rights reserved.
//

import Foundation

/// 1. Parse input

/// 2. Parse Keys.plist
/// - For each key:
///   - Allocate key space greater than key length (i.e. 32 bytes => 64-length, 18 bytes => 32 bytes, etc.)
///   - Randomize placement of key byte locations

/// 3. Generate Secrets.swift
