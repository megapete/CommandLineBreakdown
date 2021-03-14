//
//  AppController.swift
//  CommandLineBreakdown
//
//  Created by Peter Huber on 2021-03-14.
//

import Cocoa

extension NSTextField {
    
    func DuplicateLabelWithOffset(dx:CGFloat, dy:CGFloat) -> NSTextField
    {
        let newField = NSTextField(labelWithString: self.stringValue)
        newField.frame = self.frame.offsetBy(dx: dx, dy: dy)
        newField.font = self.font
        
        return newField
    }
}

class AppController: NSObject {
    
    var cmdLineComponents:[String] = []
    
    @IBOutlet weak var cmdLineField: NSTextField!
    
    @IBOutlet weak var commandNameField: NSTextField!
    @IBOutlet weak var argFlagField: NSTextField!
    
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
        
        // print("\(items.count) items on the clipboard")
        
        guard let cmdLine = items[0].string(forType: .string) else
        {
            print("First object is not a string")
            return
        }
        
        self.cmdLineField.stringValue = cmdLine
        
        // copy the command line as components separated by spaces (get rid of multiple spaces)
        self.cmdLineComponents = cmdLine.components(separatedBy: .whitespaces).filter({ $0 != ""})
        
        let commLine = CommandLine(cmdLineComponents: self.cmdLineComponents)
        
        print("Number of arguments: \(commLine.arguments.count); Number of flags: \(commLine.flags.count)")
        
        self.commandNameField.stringValue = commLine.name
        
        
        
        for nextArg in commLine.arguments
        {
            
        }
    }
}
