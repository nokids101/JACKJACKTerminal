import Foundation

// FLACShellWrapper.swift
// Handles shell-safe metaflac execution for both tag reading and raw metadata args.
// Fully Unicode-safe: supports dashes, emojis, accents, curly quotes, etc.

struct FLACShellWrapper {
    
    // This function is hardcoded to expect --show-tag=TAG and to deal with '-' weird hyphens and other filename anomalies
    // Reads a FLAC tag (like ARTIST, TITLE) using metaflac --show-tag
    // - Parameters:
    //   - tag: The FLAC metadata tag name (e.g. "ARTIST")
    //   - path: The FLAC file URL
    // - Returns: Raw shell output string (may include multiple lines if multiple values)
    static func run(tag: String, path: URL) -> String {
        let process = Process()
        let pipe = Pipe()

        let possiblePaths = [
            "/opt/homebrew/bin/metaflac",
            "/usr/local/bin/metaflac",
            "/opt/local/bin/metaflac"
        ]

        guard let metaflacPath = possiblePaths.first(where: { FileManager.default.fileExists(atPath: $0) }) else {
            return "⚠️ metaflac not found"
        }

        let cleanPath = (path.path as NSString).fileSystemRepresentation

        process.executableURL = URL(fileURLWithPath: metaflacPath)
        process.arguments = ["--show-tag=\(tag)", String(cString: cleanPath)]
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return "⚠️ metaflac failed: \(error.localizedDescription)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
    }


    
    // Reads a raw value from metaflac using direct argument (e.g., --show-sample-rate)
    // - Parameters:
    //   - arg: A metaflac flag like "--show-bps"
    //   - path: The FLAC file URL
    // - Returns: Raw output string or error message
    static func runArg(arg: String, path: URL) -> String {
        let process = Process()
        let pipe = Pipe()

        let possiblePaths = [
            "/opt/homebrew/bin/metaflac",
            "/usr/local/bin/metaflac",
            "/opt/local/bin/metaflac"
        ]

        guard let metaflacPath = possiblePaths.first(where: { FileManager.default.fileExists(atPath: $0) }) else {
            return "⚠️ metaflac not found"
        }

        let cleanPath = (path.path as NSString).fileSystemRepresentation

        process.executableURL = URL(fileURLWithPath: metaflacPath)
        process.arguments = [arg, String(cString: cleanPath)]
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return "⚠️ metaflac failed: \(error.localizedDescription)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
