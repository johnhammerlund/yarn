import XCTest

import yarnTests

var tests = [XCTestCaseEntry]()
tests += yarnTests.allTests()
XCTMain(tests)
