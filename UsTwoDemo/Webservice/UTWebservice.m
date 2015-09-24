//
//  UTWebservice.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTWebservice.h"
#import "UTRate.h"
#import "Constantes.h"

@interface UTWebservice ()

@property (nonatomic, copy) NSArray <UTRate *> *ratesList;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

@implementation UTWebservice

+ (instancetype)sharedManager
{
    static UTWebservice *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

//
//	Retrieve AUD currency rate from fixer.io
//  -> CAD, EUR, GBP, JPY, USD
//------------------------------------------------------------------------------
- (void)getCurrencyAUDRates:(UTGetCurrencyList)completionBlock {
    
    self.ratesList = nil;
    
    static NSString *stringURL = @"https://api.fixer.io/latest?base=AUD&symbols=CAD,EUR,GBP,JPY,USD";
    
    [self callHTTPGETNSURLRequest:stringURL
                  completionBlock:^(NSDictionary *responseJSON) {
                      
                      NSMutableArray *tmpArray = [NSMutableArray array];
                      
                      if (DictionaryNotNull(responseJSON)) {
                          
                          NSString *base = responseJSON[@"base"];
                          NSDictionary *rates = responseJSON[@"rates"];
                          if ([base isEqualToString:@"AUD"] && DictionaryNotNull(rates)) {
                              
                              // Parse and create UTRate Model
                              [responseJSON[@"rates"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                  if (NumberNotNull(obj)) {
                                      UTRate *rate = [UTRate createModelCurrency:key ratio:obj];
                                      [tmpArray addObject:rate];
                                  }
                              }];
                          }
                      }
                      
                      if (tmpArray.count)
                          self.ratesList = [[NSArray alloc] initWithArray:tmpArray];
                      
                      if (completionBlock)
                          completionBlock(self.ratesList);
                      
                  } failedBlock:^(NSError *error) {
                      if (completionBlock)
                          completionBlock(nil);
                  }];
}

//
//	Async HTTP GET Request and return a JSON object : dictionary or array
//------------------------------------------------------------------------------
- (void)callHTTPGETNSURLRequest:(NSString *)URLString
                completionBlock:(void(^)(id responseJSON))successBlock
                    failedBlock:(void(^)(NSError *error))failedBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URLString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         id resultJSON = nil;
         
         if (!connectionError) {
             resultJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&connectionError];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (connectionError) {
                 NSLog(@"Webservice Error : %@\n%@", URLString, connectionError);
                 if (failedBlock) {
                     failedBlock (connectionError);
                 }
             } else {
                 NSLog(@"Webservice Response : %@\n%@", URLString, resultJSON);
                 if (successBlock) {
                     successBlock (resultJSON);
                 }
             }
         });
     }];
}

@end
