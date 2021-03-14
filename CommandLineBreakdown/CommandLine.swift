//
//  CommandLine.swift
//  CommandLineBreakdown
//
//  Created by Peter Huber on 2021-03-14.
//

import Foundation

struct CommandLine {
    
    // The full path of the command to execute
    let name:String
    
    // The arguements to the command (basically, anything that is not preceded by a "-XXX" patter
    let arguments:[String]
    
    // Flags are alwasy preceded by "-" or "--" on the command line. If the component immediately following the flag does not have a "-", it is assumed to be the argument to the precdeing flag. The key is the flag WITHOUT THE DASH(ES).
    let flags:[String:String]
    
    init(cmdLineComponents:[String])
    {
        var currentComponent = 0
        
        self.name = cmdLineComponents[currentComponent]
        currentComponent += 1
        
        var args:[String] = []
        var cmdflags:[String:String] = [:]
        
        while currentComponent < cmdLineComponents.count
        {
            let nextString = cmdLineComponents[currentComponent]
            currentComponent += 1
            
            if nextString.hasPrefix("-") || nextString.hasPrefix("--")
            {
                var key = String(nextString.dropFirst(1))
                if nextString.hasPrefix("--")
                {
                    key = String(nextString.dropFirst(1))
                }
                
                if currentComponent < cmdLineComponents.count
                {
                    if cmdLineComponents[currentComponent].hasPrefix("-")
                    {
                        cmdflags[key] = ""
                    }
                    else
                    {
                        cmdflags[key] = cmdLineComponents[currentComponent]
                        currentComponent += 1
                    }
                }
            }
            else
            {
                args.append(nextString)
            }
        }
        
        self.arguments = args
        self.flags = cmdflags
    }
}
