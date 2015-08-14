//
//  GenericDAO.m
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "GenericDAO.h"
#import "AppConstants.h"

@implementation GenericDAO

+(GenericDAO*)sharedGenericDAO
{
    static GenericDAO * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)find:(Class) modelType withParameters:(NSDictionary *) params completionHandler:(void(^)(NSArray*))handler
{
    NSString * _controllerName ;
    if(controllerName!=nil)
        _controllerName = controllerName;
    else
       _controllerName =[NSString stringWithFormat:@"%@s", NSStringFromClass(modelType)];
    NSMutableString * _url =[[NSMutableString alloc] init];
    [_url appendString: BACKEND_URL(_controllerName,@"index")];
    if (params!=nil && [params isKindOfClass:[NSDictionary class]] && [params count]>0) {
        NSEnumerator * emt = [params keyEnumerator];
        NSString * _key;
        while ((_key = [emt nextObject])!=nil) {
            NSString * _value = [params objectForKey:_key];
            [_url appendString:[NSString stringWithFormat:@"/%@:%@",_key,_value]];
        }
    }
    [_url appendString:@".json"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // boardcast a notification to invoke a progress indicator & tells other model holders to notice.
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MODEL_FETCHING object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:NSStringFromClass(modelType),@"modelname",nil]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *rawdata, NSError *error)
    {
        // boardcast a notification to stop a progress indicator & tells other model holders to notice.
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MODEL_CHANGED object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:_controllerName,@"modelname",nil]];
        NSError * err =nil;
        NSMutableArray * _arr =[[[NSMutableArray alloc] init] autorelease];
        NSDictionary * data =[NSJSONSerialization JSONObjectWithData:rawdata options:NSJSONReadingMutableContainers error:&err];
        if (error==nil && err == nil && [data isKindOfClass:[NSDictionary class]]){
            NSArray * _modelarray = [(NSDictionary *) data objectForKey:_controllerName];
            for (int i=0; i<[_modelarray count]; i++) {
                NSDictionary * _dict = [_modelarray objectAtIndex:i];
                BaseModel * _model = [[modelType alloc] initWithJSON:_dict];
                [_arr addObject:_model];
            }
        }
     handler(_arr);
    }];
}
@end
