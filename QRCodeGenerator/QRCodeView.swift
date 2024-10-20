//
//  QRCodeView.swift
//  QRCodeGenerator
//
//  Created by Masato Takamura on 2024/10/19.
//

import SwiftUI

struct QRCodeView: View {
    
    @State private var viewModel = QRCodeViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            TextField("Enter URL", text: $viewModel.urlString)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
                .onSubmit {
                    isFocused = false
                }
            
            Button {
                // Generate QR Code
                viewModel.generateQRCode()
            } label: {
                Text("Create")
                    .padding(8)
                    .fontWeight(.bold)
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()

            if let qrCodeImage = viewModel.qrCodeImage {
                Image(uiImage: qrCodeImage)
                    // If you don't specify `.none`, the QR code will look blurry.
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Spacer()
            }
            
        }
        .padding()
    }
}

#Preview {
    QRCodeView()
}
