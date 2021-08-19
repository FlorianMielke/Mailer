/**
 *  Mailer
 *  Copyright (c) Florian Mielke 2021
 *  MIT license, see LICENSE file for details
 */

import XCTest

import ZeitgeistTests

var tests = [XCTestCaseEntry]()
tests += MailerTests.allTests()
XCTMain(tests)
