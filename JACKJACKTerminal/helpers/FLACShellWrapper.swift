import Foundation

/// Runs `metaflac` using a full binary path (resolved from ToolManager)
/// Handles filenames with Unicode safely using fileSystemRepresentation
struct FLACShellWrapper {
    
    /// Show a specific tag (e.g. TITLE, ARTIST) from a FLAC file
    /// - Parameters:
    ///   - metaflacPath: Full path to `metaflac` binary (resolved externally)
    ///   - tag: Metadata tag to show
    ///   - path: FLAC file to scan
    static func run(using metaflacPath: String, tag: String, path: URL) -> String {
        let process = Process()
        let pipe = Pipe()
        
        let cleanPath = (path.path as NSString).fileSystemRepresentation
        
        process.executableURL = URL(fileURLWithPath: metaflacPath)
        process.arguments = ["--show-tag=\(tag)", String(cString: cleanPath)]
        process.standardOutput = pipe
        process.standardError = pipe
        
        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return "❌ metaflac failed: \(error.localizedDescription)"
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }

    /// Run an arbitrary metaflac argument (e.g. --show-total-samples)
    /// - Parameters:
    ///   - metaflacPath: Full path to `metaflac` binary
    ///   - arg: Full CLI argument (e.g., "--show-total-samples")
    ///   - path: FLAC file to run it on
    static func runArg(using metaflacPath: String, arg: String, path: URL) -> String {
        let process = Process()
        let pipe = Pipe()
        
        let cleanPath = (path.path as NSString).fileSystemRepresentation
        
        process.executableURL = URL(fileURLWithPath: metaflacPath)
        process.arguments = [arg, String(cString: cleanPath)]
        process.standardOutput = pipe
        process.standardError = pipe
        
        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return "❌ metaflac failed: \(error.localizedDescription)"
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
}
