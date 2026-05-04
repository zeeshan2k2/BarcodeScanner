//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Zeeshan Waheed on 04/04/2026.
//

import Foundation
import SwiftUI
import Combine

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var isShowingResult: Bool {
        !scannedCode.isEmpty
    }
    
    var statusText: String {
        scannedCode.isEmpty ? "No code scanned yet" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? Color(uiColor: .secondaryLabel) : .primary
    }
    
    var statusTitle: String {
        scannedCode.isEmpty ? "Ready" : "Scanned Code"
    }
    
    var helperText: String {
        scannedCode.isEmpty
        ? "Center an EAN-8 or EAN-13 barcode in the frame."
        : "Tap reset when you want to scan a different code."
    }
    
    func resetScanner() {
        scannedCode = ""
    }
}
