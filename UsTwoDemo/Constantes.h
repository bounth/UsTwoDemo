//
//  Constantes.h
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#define StringNotNull(obj)  ([obj isKindOfClass:[NSString class]]) ? obj : nil
#define NumberNotNull(obj)  ([obj isKindOfClass:[NSNumber class]]) ? obj : nil
#define DictionaryNotNull(obj)  ([obj isKindOfClass:[NSDictionary class]]) ? obj : nil
#define ArrayNotNull(obj)  ([obj isKindOfClass:[NSArray class]]) ? obj : nil
