import Foundation

// A lightweight wrapper around `Process` that executes shell commands with
// full binary paths. Expects `args[0]` to be the full path to the command.
struct ShellHelper {
    
    // Runs a shell command using the full binary path (not relying on PATH).
    // - Parameter args: Full command array, e.g. ["/opt/homebrew/bin/flac", "-t", "file.flac"]
    // - Returns: Output (stdout + stderr) as a string
    static func runShell(_ args: [String]) -> String {
        let task = Process()
        let pipe = Pipe()

        // ✅ First argument is the full path to the binary (resolved earlier via ToolManager)
        guard let binaryPath = args.first else {
            return "❌ No command provided"
        }

        task.executableURL = URL(fileURLWithPath: binaryPath)
        task.arguments = Array(args.dropFirst())
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            return "❌ Shell run failed: \(error.localizedDescription)"
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
}
