//
//  OCTirinhasSingleton.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCTirinhasSingleton.h"
#import "OCTirinha.h"


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
    [_tirinhas addObject:tirinha];
}

- (void)removeTirinhaAtIndex:(NSUInteger)indice {
    [_tirinhas removeObjectAtIndex:indice];
}

-(UIImage *)renderizarImagem : (UIImage *)imagem{
    
    //dispatch_queue_t myQueue = dispatch_queue_create("ImageQueue",NULL);
    //dispatch_async(myQueue, ^{
        
        GPUImageSmoothToonFilter *filter = [[GPUImageSmoothToonFilter alloc] init];
        filter.threshold = 0.1;
        
        UIImage *filteredImage = imagem;
        
        filteredImage = [[[GPUImageHighlightShadowFilter alloc] init] imageByFilteringImage:filteredImage];
        filteredImage = [[[GPUImageGaussianBlurFilter alloc] init] imageByFilteringImage:filteredImage];
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

@end
