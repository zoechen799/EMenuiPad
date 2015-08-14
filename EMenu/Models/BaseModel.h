//
//  BaseModel.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
-(id)initWithJSON: (NSDictionary*) jsonObj;
-(void)addAssocaitions:(id) accocaitionJson forKey:(NSString *) key;
@end
