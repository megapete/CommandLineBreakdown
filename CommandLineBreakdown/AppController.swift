//
//  AppController.swift
//  CommandLineBreakdown
//
//  Created by Peter Huber on 2021-03-14.
//

import Cocoa

class AppController: NSObject {
    
    var cmdLineComponents:[String] = []
    
    @IBOutlet weak var cmdLineField: NSTextField!
    
    @IBAction func handlePasteNewCmdLine(_ sender: Any) {
        
        guard let items = NSPasteboard.general.pasteboardItems else
        {
            print("Couldn't get clipboard array")
            return
        }
        
        if items.isEmpty
        {
            print("There is nothing on the clipboard")
            return
        }
        
        print("\(items.count) items on the clipboard")
        
        guard let cmdLine = items[0].string(forType: .string) else
        {
            print("First object is not a string")
            return
        }
        
        self.cmdLineField.stringValue = cmdLine
        
        // copy the command line as components separated by spaces (get rid of multiple spaces)
        self.cmdLineComponents = cmdLine.components(separatedBy: .whitespaces).filter({ $0 != ""})
        
        let commLine = CommandLine(cmdLineComponents: self.cmdLineComponents)
    }
}
