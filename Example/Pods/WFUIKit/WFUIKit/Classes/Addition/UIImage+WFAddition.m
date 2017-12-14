//
//  UIImage+WFAddition.m
//  Pods
//
//  Created by redye.hu on 2017/6/7.
//
//

#import "UIImage+WFAddition.h"

@implementation UIImage (WFAddition)

+ (UIImage *)imageWithColor:(UIColor *) color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f,0.0f,size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height{
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    CGFloat scaleX = width / qrcodeImage.extent.size.width;
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

+ (UIImage *)qrCodeImageWithString:(NSString *)string{
    
    NSData *stringData = [string dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    return [UIImage imageWithCIImage:qrFilter.outputImage scale:1.0 orientation:UIImageOrientationDown];
    
}


+ (UIImage *)imageFromView:(UIView *)view
{
    return [self imageFromView:view inset:UIEdgeInsetsZero];
}

+ (UIImage *)imageFromView:(UIView *)view inset:(UIEdgeInsets)inset
{
    CGSize size = view.frame.size;
    size.width = size.width - inset.left;
    size.width = size.width - inset.right;
    size.height = size.height - inset.top;
    size.height = size.height - inset.bottom;
    
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
    
    //    return img;
    
}

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = (int) (normal.size.width * 0.4);
    CGFloat h = (int) (normal.size.height * 0.5);
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w , h, w) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize fitScale:(BOOL)fitScale {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (fitScale) {
        return [self imageByScalingToSize:CGSizeMake(targetSize.width * scale, targetSize.height * scale)];
    } else {
        return [self imageByScalingToSize:targetSize];
    }
}


//按最大的放大 并截取中间  适合头像 和一些小图展示
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (scaledHeight > targetHeight) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        if (targetWidth < scaledWidth) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods
// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if((bitmapInfo == kCGImageAlphaLast) || (bitmapInfo == kCGImageAlphaNone))
        bitmapInfo = (CGBitmapInfo)kCGImageAlphaNoneSkipLast;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                bitmapInfo);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    return transform;
}

+ (NSData *)compressToSize:(long)targetSize image:(UIImage *)image {
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    return [self compressToSize:targetSize sourceSize:imgData.length image:image];
}


+ (NSData *)compressToSize:(long)targetSize sourceSize:(long)sourceSize image:(UIImage *)image {
    NSLog(@"targetSize:%lu originSize%lu", targetSize, sourceSize);
    
    if (sourceSize <= targetSize) {
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        return data;
    }
    
    CGFloat compression = (CGFloat)targetSize / (CGFloat)sourceSize;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSLog(@"compression:%f size:%lu", compression, (unsigned long)[imageData length]);
    
    return imageData;
}

+ (UIImage *)frameworkImageWithClass:(Class)aclass name:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:aclass];
    NSString* path = [bundle pathForResource:name ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    
    return image;
}

+ (UIImage *)frameworkImage:(Class)aclass bundleName:(NSString *)bundleName imageName:(NSString *)imageName {
    NSBundle *currentBundle = [NSBundle bundleForClass:aclass];
    NSString *strResourcesBundle = [currentBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:strResourcesBundle];
    NSString *path = [bundle pathForResource:imageName ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    
    return image;
}


@end
