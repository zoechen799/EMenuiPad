//
//  BaseModel.m
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

-(id)initWithJSON: (NSDictionary*) jsonObj
{
    [self init];
    NSString * className = NSStringFromClass([self class]);
    //Get the class it self from Json data , without it's relation class data
    NSDictionary * _mainModelDict = [jsonObj objectForKey:className];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[[NSString alloc] initWithCString:property_getName(property)] autorelease];
        id jsonValue = nil;
        if([propertyName isEqualToString:@"ID"]){
            jsonValue = [_mainModelDict objectForKey:@"id"];
        }else if([propertyName isEqualToString:@"Description"]){
            jsonValue = [_mainModelDict objectForKey:@"description"];
        }else{
            jsonValue = [_mainModelDict objectForKey:propertyName];
        }
        if (jsonValue) [self setValue:jsonValue forKey:propertyName];
    }
    free(properties);
    if([self respondsToSelector:@selector(addAssocaitions: forKey:)]){
        [jsonObj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self addAssocaitions:obj forKey:key];
        }];
    }
    return self;
}

- (NSString *)description
{
    NSMutableDictionary * _data =[[NSMutableDictionary alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[[NSString alloc] initWithCString:property_getName(property)] autorelease];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [_data setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return _data.description;
}
@end
