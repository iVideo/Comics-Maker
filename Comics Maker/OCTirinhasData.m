//
//  OCTirinhasData.m
//  Comics Maker
//
//  Created by Lucas Augusto Cordeiro on 3/11/14.
//  Copyright (c) 2014 Lucas Augusto Cordeiro. All rights reserved.
//

#import "OCTirinhasData.h"
#import "OCTirinhasDatabase.h"
#define kTitleKey       @"Title"
#define kRatingKey      @"Rating"


@implementation OCTirinhasData

@synthesize title = _title;
@synthesize rating = _rating;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (id)initWithTitle:(NSString*)title rating:(float)rating {
    if ((self = [super init])) {
        _title = [title copy];
        _rating = rating;
    }
    return self;
}

- (void)dealloc {
    _title = nil;
}

#pragma mark NSCoding

//Encoder
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeFloat:_rating forKey:kRatingKey];
}

//Decoder
- (id)initWithCoder:(NSCoder *)decoder {
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    float rating = [decoder decodeFloatForKey:kRatingKey];
    return [self initWithTitle:title rating:rating];
}


@end
