import AVFoundation
import AVKit
import CoreImage
import Foundation

struct SampleBufferTransformer {

    enum Filter: String {
        case colorInvert = "CIColorInvert"
    }

    func transform(videoSampleBuffer: CMSampleBuffer, with filter: Filter) -> CMSampleBuffer {
        let context = CIContext(options: nil)
        guard let cvImageBuffer = CMSampleBufferGetImageBuffer(videoSampleBuffer) else {
            print("failed to get pixel buffer")
            fatalError()
        }
        let ciMask: CIImage = CIImage(cvImageBuffer: cvImageBuffer)
        let filter = CIFilter(name: filter.rawValue, parameters: [kCIInputImageKey: ciMask])

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
