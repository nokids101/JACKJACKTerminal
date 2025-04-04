import Foundation
import AppKit

// InputFolderHandler.swift
// Opens a folder picker and returns the selected URL
// Handles receiving and validating a folder path, then you can run another program for finidng all the FLAC files, other files like .wav

struct InputFolderHandler {
    static func getFolder() -> URL? {
        let panel = NSOpenPanel()
        panel.title = "Choose a folder with FLAC files"
      //  panel.showsResizeIndicator = true
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false

        let response = panel.runModal()
        return response == .OK ? panel.url : nil
    }
}
