//
//  MyURLCache.m
//  iOSShell
//
//  Created by Adrian Yin on 11/3/12.
//  Copyright (c) 2012 SAP Business One. All rights reserved.
//

#import "MyURLCache.h"
#import "AppConstants.h"
#define MATCHS(a,b) [a rangeOfString: b].location != NSNotFound
@interface MyURLCache ()
@property (strong) NSMutableDictionary *cachedResponses;
@end

@implementation MyURLCache


- (NSString *)substitutionPaths:(NSString*) originalURL
{
    if(MATCHS(originalURL, @"Restaurants/index.json"))
    {
        return @"Restaurants_index.json";
    }
    if(MATCHS(originalURL, @"imageservice"))
    {
        NSString * fileName = [originalURL substringFromIndex:[originalURL rangeOfString:@"imageservice"].location + [@"imageservice" length] +1];
        return fileName;
    }
    if (MATCHS(originalURL, @"Dishes/index")) {
       NSString *fileName = [originalURL substringFromIndex: [originalURL rangeOfString:@"Dishes/index"].location];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@":" withString:@""];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"restaurant_id" withString:@"rid"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"dish_pictures" withString:@"pic"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"category_id" withString:@"cat"];
        return fileName;
    } 
    return nil;
}
-(NSArray *)getFileNameAndExtension:(NSString *)fullPath
{
    int dotIndex =[fullPath rangeOfString:@"." options: NSBackwardsSearch].location;
    if (dotIndex == NSNotFound) {
        return nil;
    }
    NSString * name = [fullPath substringToIndex:dotIndex];
    NSString * ext = [fullPath substringFromIndex:dotIndex+1];
    NSArray *retArr =[NSArray arrayWithObjects:name,ext, nil];
    return retArr;
}
- (NSString *)mimeTypeForPath: (NSString *)extension
{
    if([extension isEqualToString:@"json"])
        return @"application/json";
    else if ([extension isEqualToString:@"jpg"])
        return @"image/jpeg";
    else
        return @"";
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
    NSCachedURLResponse *response = nil;

    // Get the path for the request
    NSString *path = [[request URL ] absoluteString];
    
    NSString *substitutionFileName = [self substitutionPaths:path];
    if (!substitutionFileName) {
        response = [super cachedResponseForRequest:request];
    }
    if (!response && substitutionFileName && DUMMY==YES)
    {
        // Get the path to the substitution file
        NSString *substitutionFilePath =
        [[NSBundle mainBundle] pathForResource:[substitutionFileName stringByDeletingPathExtension]
         ofType:[substitutionFileName pathExtension]];
        NSAssert(substitutionFilePath,
                 @"File %@ in substitutionPaths didn't exist", substitutionFileName);
        
        // Load the data
        NSData *data = [NSData dataWithContentsOfFile:substitutionFilePath];
        
        // Create the cacheable response
        NSURLResponse *tmpResponse = [[NSURLResponse alloc]
          initWithURL:[request URL]
          MIMEType:[self mimeTypeForPath:[substitutionFileName pathExtension]]
          expectedContentLength:[data length]
          textEncodingName:@"utf-8"];
        response = [[NSCachedURLResponse alloc] initWithResponse:tmpResponse data:data];
    
    }
    
    return response;
}
@end
