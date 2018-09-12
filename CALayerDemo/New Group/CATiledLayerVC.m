//
//  CATiledLayerVC.m
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "CATiledLayerVC.h"

#define CScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define CScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface CATiledLayerVC ()<CALayerDelegate>

@property(nonatomic,strong) CATiledLayer *tiledLayer;


@end

@implementation CATiledLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 切图保存在沙盒
    [self cutImageAndSave];
    
    // 添加CATiledLayer
    [self addTiledLayer];
}

/**
 *  平铺layer 可用于展示大图
 *  展示大图时可能会引起卡顿(阻塞主线程),将大图切分成小图,然后用到他们(需要展示)的时候再加载(读取)
 */
- (void)addTiledLayer{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CScreenWidth, CScreenHeight)];
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = self.tiledLayer.frame.size;
    [scrollView.layer addSublayer:_tiledLayer];
    [_tiledLayer setNeedsDisplay];
}

- (CATiledLayer*)tiledLayer{
    if (!_tiledLayer) {
        UIImage *image = [UIImage imageNamed:@"IMG_1668.JPG"];
        _tiledLayer = [CATiledLayer layer];
        _tiledLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _tiledLayer.delegate = self;
        _tiledLayer.tileSize = CGSizeMake(200, 200);
    }
    return _tiledLayer;
}


#pragma mark - CALayerDelegate
/**
 *  加载图片
 *  CALayerDelegate
 *  支持多线程绘制，-drawLayer:inContext:方法可以在多个线程中同时地并发调用
 *  所以请小心谨慎地确保你在这个方法中实现的绘制代码是线程安全的.(不懂哎)
 */
- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    //load tile image
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *imageName = [NSString stringWithFormat:@"%@/pic-%02ld-%02ld.png",filePath,x,y];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imageName];
    
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

#pragma mark - 切图保存在沙盒

//切图保存到沙盒
- (void)cutImageAndSave{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *imageName = [NSString stringWithFormat:@"%@/pic-00-00.png",filePath];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imageName];
    NSLog(@"%@",imageName);
    if (tileImage) return;
    
    UIImage *image = [UIImage imageNamed:@"IMG_1668.JPG"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat WH = 200; // 切割图片尺寸
    CGSize size = image.size;
    // ceil 向上取整
    NSInteger rows = ceil(size.height / WH);
    NSInteger cols = ceil(size.width / WH);
    
    for (int x = 0; x < rows; x++) {  // 行
        for (int y = 0; y < cols; y++) { // 列
            UIImage *subImage = [self captureView:imageView Frame:CGRectMake(y*WH, x*WH, WH, WH)];
            NSString *path = [NSString stringWithFormat:@"%@/pic-%02d-%02d.png",filePath,y,x];
            [UIImagePNGRepresentation(subImage) writeToFile:path atomically:YES];
        }
    }
}

//切图
- (UIImage*)captureView:(UIView *)theView Frame:(CGRect)frame{
    //开启图形上下文 将heView的所有内容渲染到图形上下文中
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, frame);
    UIImage *image = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return image;
}

@end
