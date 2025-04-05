import Foundation

// VerifyRunner.swift
// Runs `flac -t` on a single FLAC file
// Returns only the one line of output that matches the file
// The engine will decide if it's OK, warning, or error

struct VerifyRunner {
    static func runFLACVerify(url: URL) -> String {
        let task = Process()
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe // Capture errors too

        // ✅ Use the detected FLAC binary path
        guard let flacPath = ToolManager.path(for: "flac") else {
            return "FLAC binary not found"
        }
        task.executableURL = URL(fileURLWithPath: flacPath)
        task.arguments = ["-t", url.path]

        // 🏃 Launch the process
        do {
            try task.run()
        } catch {
            // ❌ If it fails to run, return failure message
            return "Unable to run flac -t"
        }

        // 📥 Read all output (stdout + stderr)
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // 🔍 Return only the line that references this file
        let lines = output.components(separatedBy: .newlines)

        // ✅ If we find a line that mentions the filename, return it
        if let match = lines.first(where: { $0.contains(url.lastPathComponent) }) {
            return match.trimmingCharacters(in: .whitespaces)
        }

        // ❓ Fallback: if nothing matched, return last line or entire output
        return lines.last?.trimmingCharacters(in: .whitespaces) ?? output
    }
}
