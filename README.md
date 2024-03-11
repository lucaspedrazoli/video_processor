# Video Processor

Video processing pipeline with Core Image. The function takes a video sample buffer, applies a Core Image filter specified by the `Filter` enum, and returns a new sample buffer with the filter applied.

**Parameters:**
- `videoSampleBuffer`: A CMSampleBuffer, which is a container for video and audio data.
- `filter`: An enum type `Filter` indicating the Core Image filter to be applied.

This `CIContext` is used for rendering Core Image images.

**Implementation Step by Step:**
1. Extract the pixel buffer (`CVPixelBuffer`) from the input `videoSampleBuffer`.
2. Create a `CIImage` from the pixel buffer. `CIImage` represents an image to be processed.
3. A `CIFilter` is created using the filter name from the `Filter` enum. The input image for the filter is set to the `ciMask` image.
4. Obtain the `outputImage` from the filter. This image is then rendered to the original `cvImageBuffer` using the `CIContext`.
5. The `cvImageBuffer` is mapped to a new `CMSampleBuffer` using a custom helper.
