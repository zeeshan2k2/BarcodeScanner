//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Zeeshan Waheed on 03/04/2026.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    scannerSection
                    resultSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
            .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Scanner")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: alertItem.dismissBtn
                )
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Barcode Scanner")
                .font(.system(size: 28, weight: .semibold, design: .rounded))
            
            Text("Place an EAN-8 or EAN-13 barcode inside the frame.")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
    
    private var scannerSection: some View {
        ZStack {
            ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            
            scannerOverlay
        }
        .background(Color.black, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        }
    }
    
    private var scannerOverlay: some View {
        GeometryReader { geometry in
            let frameWidth = geometry.size.width * 0.72
            let frameHeight = min(geometry.size.height * 0.48, 170.0)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white.opacity(0.95), lineWidth: 2)
                    .frame(width: frameWidth, height: frameHeight)
                
                VStack(spacing: 10) {
                    Spacer()
                    
                    Text("Align barcode here")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.black.opacity(0.4), in: Capsule())
                }
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var resultSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.statusTitle)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    
                    Text(viewModel.statusText)
                        .font(.system(size: viewModel.isShowingResult ? 24 : 20, weight: .semibold, design: .rounded))
                        .foregroundStyle(viewModel.statusTextColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                }
                
                Spacer()
                
                Circle()
                    .fill(viewModel.isShowingResult ? Color.green : Color.gray.opacity(0.35))
                    .frame(width: 12, height: 12)
            }
            
            Text(viewModel.helperText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Button {
                viewModel.resetScanner()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Reset")
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        }
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
