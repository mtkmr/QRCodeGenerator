//
//  QRCodeViewModel.swift
//  QRCodeGenerator
//
//  Created by Masato Takamura on 2024/10/19.
//

import CoreImage
import UIKit

@MainActor
@Observable
final class QRCodeViewModel {
    
    var urlString = ""
    var qrCodeImage: UIImage?
    
    private let context = CIContext()
    
    func generateQRCode() {
        guard let data = urlString.data(using: .utf8) else { return }
        /*
         * inputMessage
         * The data to be encoded as a QR code. An NSData object whose display name is Message.
         *
         * inputCorrectionLevel
         * A single letter specifying the error correction format. An NSString object whose display name is CorrectionLevel.
         * Default value: M
         *
         * https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator
         */
        let qr = CIFilter(
            name: "CIQRCodeGenerator",
            parameters: [
                "inputMessage": data,
                "inputCorrectionLevel": "M",
            ]
        )
        let transform = CGAffineTransform(scaleX: 1, y: 1)
        guard let outputImage = qr?.outputImage?.transformed(by: transform),
              // CIImage -> CGImage
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        // CGImage -> UIImage
        self.qrCodeImage = UIImage(cgImage: cgImage)
    }
}
