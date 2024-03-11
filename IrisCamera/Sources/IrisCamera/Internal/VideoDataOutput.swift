import AVKit
import OSLog
import Foundation

class VideoDataOutput: NSObject {
    var displayLayer: AVSampleBufferDisplayLayer?

    var sampleBufferTransformer = SampleBufferTransformer()
    let videoOutput = AVCaptureVideoDataOutput()
    let dataOutputQueue = DispatchQueue(label: "com.irisona.data-output-queue")
}

extension VideoDataOutput: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let newBuffer = sampleBufferTransformer.transform(videoSampleBuffer: sampleBuffer, with: .colorInvert)

        displayLayer?.sampleBufferRenderer.enqueue(newBuffer)
    }
}
