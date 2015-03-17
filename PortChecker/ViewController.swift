//
//  ViewController.swift
//  PortChecker
//
//  Created by Alexey Tsymlov on 3/17/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var host: NSTextField!
    @IBOutlet weak var port: NSTextField!
    @IBOutlet var log: NSTextView!

    @IBAction func check(sender: NSButton) {
        let addr = self.host.stringValue
        let port = Int(self.port.intValue)
        let success = checkHost(addr: addr, port: port)
        if success {
            log("Connection to \(addr):\(port) - ok")
        } else {
            log("Connection to \(addr):\(port) - failure")
        }
    }
    
    func checkHost(#addr: String, port: Int) -> Bool {
        var result: Bool
        var client = TCPClient(addr: addr, port: port)
        var (success, connectingResult) = client.connect(timeout: 1)
        log(connectingResult)
        var (_, closingResult) = client.close()
        log(closingResult)
        return success
    }
    
    func log(text: String){
        log.string = ( log.string ?? "") + "\n" + text
    }

}

