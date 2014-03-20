//
//  OCTirinhasSingleton.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"
#import <Social/Social.h>


@implementation OCTirinhasSingleton

+ (id)sharedTirinhas {
    static OCTirinhasSingleton *instance = nil;
    
    if (!instance) {
        instance = [[super allocWithZone:nil] init];
    }
    return instance;
}

- (id)init {
    self = [super init];
    self.tirinhas = [[NSMutableArray alloc] init];
    self.quadroAtual = 0;
    
    return self;
}

- (void)addTirinha:(NSObject *)tirinha {
    if (!_tirinhas) {
        self.tirinhas = [[NSMutableArray alloc] init];
    }
    [_tirinhas addObject:tirinha];
}

- (void)removeTirinhaAtIndex:(NSUInteger)indice {
    [_tirinhas removeObjectAtIndex:indice];
}

-(UIImage *)renderizarImagem : (UIImage *)imagem{
    
    //dispatch_queue_t myQueue = dispatch_queue_create("ImageQueue",NULL);
    //dispatch_async(myQueue, ^{
        
        GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
        filter.threshold = 0.1;
        
        UIImage *filteredImage = imagem;
    
//        filteredImage = [[[GPUImageHighlightShadowFilter alloc] init] imageByFilteringImage:filteredImage];
        filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
//        filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
//        filteredImage = [[[GPUImageHighlightShadowFilter alloc] init] imageByFilteringImage:filteredImage];
        filteredImage = [[[GPUImageGrayscaleFilter alloc] init] imageByFilteringImage:filteredImage];
        filteredImage = [filter imageByFilteringImage:filteredImage];
        
        //filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
        //filteredImage = [[[GPUImageSmoothToonFilter alloc] init] imageByFilteringImage:filteredImage];
        
        filter = nil;
        
        
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            OCQuadro *quadro = [[OCQuadro alloc]init];
            //[quadro addImagem:_currentImage.image andTexto:nil andKey:[NSString stringWithFormat:@"tirinha_%d_quadro_%d.png", single.tirinhas.count - 1, single.quadroAtual != 0 ? single.quadroAtual - 1 : 2]];
            [quadro addTexto:nil andKey:[NSString stringWithFormat:@"tirinha_%d_quadro_%d.jpg", self.tirinhas.count - 1, self.quadroAtual != 0 ? self.quadroAtual - 1 : 2]];
            OCTirinha *t = [[self tirinhas] lastObject];
            [t adicionaQuadroNoArrayDeQuadros:quadro];

    [self salvarImagemNoDisco:filteredImage];
    return filteredImage;

}

- (UIImage *)imageByInsertingOrigemAtPoint:(CGPoint)point forBalao:(OCBaloesDeTexto *)balao atIndex:(NSUInteger)index andQuadro:(NSUInteger)quadro {
    
    OCQuadro *q = [[[_tirinhas objectAtIndex:index] quadros] objectAtIndex:quadro];
    UIImage *image = q.imagem;
	UIGraphicsBeginImageContext(image.size);
	[image drawAtPoint:CGPointZero];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[[UIColor blackColor] setStroke];
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, (_balaoAtual.inicio.x + _balaoAtual.width / 2) - 15, _balaoAtual.inicio.y > point.y ? _balaoAtual.inicio.y + 7 : _balaoAtual.inicio.y + _balaoAtual.height - 7);
    CGContextAddLineToPoint(ctx, point.x, point.y);
    CGContextAddLineToPoint(ctx, (_balaoAtual.inicio.x + _balaoAtual.width / 2) + 15, _balaoAtual.inicio.y > point.y ? _balaoAtual.inicio.y + 7 : _balaoAtual.inicio.y + _balaoAtual.height - 7);
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
    
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
	return retImage;
}

- (UIImage *)imageByInsertingBalao:(OCBaloesDeTexto *)balao atIndex:(NSUInteger)index andQuadro:(NSUInteger)quadro {
    
    _balaoAtual = balao;
    
    OCQuadro *q = [[[_tirinhas objectAtIndex:index] quadros] objectAtIndex:quadro];
    UIImage *image = q.imagem;
    
    int width = balao.texto.length < 50 ? balao.texto.length * 10 : 400;
    int height = (balao.texto.length / 50 + 1) * 50;
    
    if (width < 200) width = 200;
    if (height < 100) height = 100;
   
    balao.width = width;
    balao.height = height;
    
    UIGraphicsBeginImageContext(image.size);
    
	// draw original image into the context
	[image drawAtPoint:CGPointZero];
    
	// get the context for CoreGraphics
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	// set stroking color and draw circle
	[[UIColor blackColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect balaoRect = CGRectMake(balao.inicio.x, balao.inicio.y,
                                   width,
                                   height);
    
	//balaoRect = CGRectInset(balaoRect, 5, 5);
    
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     font, NSFontAttributeName,
                                     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,
                                     nil];
    
    
    
    
	// draw circle
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(ctx, balaoRect);
	CGContextStrokeEllipseInRect(ctx, balaoRect);
    [balao.texto drawInRect:CGRectMake(balao.inicio.x + 30, balao.inicio.y + 30, width - 60, height - 60) withAttributes:attrsDictionary];
    
    /***/
    
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint(ctx, balao.inicio.x, balao.inicio.y);
//    CGContextAddLineToPoint(ctx, balao.inicio.x + balao.width / 2, balao.inicio.y + balao.height);
//    CGContextStrokePath(ctx);
    
    /***/
	// make image out of bitmap context
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
	return retImage;
}


-(void)salvarImagemNoDisco:(UIImage *)imagem{
    NSString *imageName = [NSString stringWithFormat:@"/Documents/tirinha_%d_quadro_%d.jpg", self.tirinhas.count - 1, self.quadroAtual != 0 ? self.quadroAtual - 1 : 2];
    NSString* path = [NSHomeDirectory() stringByAppendingString:imageName];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path
                                                      contents:nil attributes:nil];
    
    if (!ok)
    {
        NSLog(@"Error creating file %@", path);
    }
    else
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImageJPEGRepresentation(imagem, 1.0)];
        [myFileHandle closeFile];
    }

}

-(void)compartilharNoFacebook: (NSInteger)indice{
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            [fbController dismissViewControllerAnimated:YES completion:nil];
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }
        };
        
        OCTirinha *tirinha = [[self tirinhas]objectAtIndex:indice];
        
        [fbController setInitialText:[tirinha titulo]];
        [fbController addImage:[tirinha tirinhaCompleta]];
        
        [fbController setCompletionHandler:completionHandler];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login!" message:@"Por favor, efetue login!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}

@end
