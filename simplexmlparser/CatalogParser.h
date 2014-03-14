//
//  CatalogParser.h
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

// This class implements some of the methods specified in the NSXMLParserDelegate protocol.
@interface CatalogParser : NSObject <NSXMLParserDelegate>

// this is the only publicly available method in this class.
- (NSMutableArray *)loadCatalog:(NSString *)inputFileName;

@end
