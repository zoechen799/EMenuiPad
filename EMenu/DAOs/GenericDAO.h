//
//  GenericDAO.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#define BACKEND_URL(c,a) [NSString stringWithFormat:@"http://localhost/orderserver/%@/%@",c,a]
@interface GenericDAO : NSObject{
    NSString * controllerName;
}
+(GenericDAO*)sharedGenericDAO;
-(void)find:(Class) modelType withParameters:(NSDictionary *) params completionHandler:(void(^)(NSArray*))handler;
@end
