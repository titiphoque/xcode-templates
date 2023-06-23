//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftyBeaver

let log = SBLoggerService.shared

class SBLoggerService {
    // fileprivate because we should use `log`
    fileprivate static let shared = SBLoggerService()

    let console = ConsoleDestination()
    let file = FileDestination()

    private init() {
        configureConsole()
        SwiftyBeaver.addDestination(file)

        if let url = file.logFileURL {
            info("Logger path: \(url)")
        }
    }

    private func configureConsole() {
        console.format = "$DHH:mm:ss.SSS$d $N.$F:$l $L: $M"
        console.levelString.verbose = "💜 VERBOSE"
        console.levelString.debug = "🪲 DEBUG"
        console.levelString.info = "💙 INFO"
        console.levelString.warning = "⚠️ WARNING"
        console.levelString.error = "🚨 ERROR"
        SwiftyBeaver.addDestination(console)
    }

    // MARK: -

    func error(_ message: Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        SwiftyBeaver.error(message, file, function, line: line, context: context)
    }

    func verbose(_ message: Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        SwiftyBeaver.verbose(message, file, function, line: line, context: context)
    }

    func debug(_ message: Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        SwiftyBeaver.debug(message, file, function, line: line, context: context)
    }

    func warning(_ message: Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        SwiftyBeaver.warning(message, file, function, line: line, context: context)
    }

    func info(_ message: Any, _ file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        SwiftyBeaver.info(message, file, function, line: line, context: context)
    }

}