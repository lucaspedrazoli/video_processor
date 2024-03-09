import AVFoundation
import AVKit
import CoreImage
import Foundation

struct SampleBufferTransformer {

    let context = CIContext(options: nil)

    func transform(videoSampleBuffer: CMSampleBuffer) -> CMSampleBuffer {
        guard let cvImageBuffer = CMSampleBufferGetImageBuffer(videoSampleBuffer) else {
            print("failed to get pixel buffer")
            fatalError()
        }
        let ciMask: CIImage = CIImage(cvImageBuffer: cvImageBuffer)
        let filter = CIFilter(name: "CIColorInvert", parameters: [kCIInputImageKey: ciMask])

        guard let outputImage: CIImage = filter?.outputImage else { fatalError() }
        context.render(outputImage, to: cvImageBuffer)


        let presentationTimestamp = CMSampleBufferGetPresentationTimeStamp(videoSampleBuffer)
        guard let result = try? cvImageBuffer.mapToSampleBuffer(timestamp: presentationTimestamp) else {
            fatalError()
        }
        return result
    }
}

extension CIImage {
    convenience init(buffer: CMSampleBuffer) {
        self.init(cvPixelBuffer: CMSampleBufferGetImageBuffer(buffer)!)
    }
}
