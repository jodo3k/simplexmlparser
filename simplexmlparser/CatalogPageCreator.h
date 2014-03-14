//
//  CatalogPageCreator.h
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatalogPageCreator : NSObject

// public methods for loading catalog, generating HTML and writing that to a file.
- (id)initWithCatalog:(NSMutableArray *)loadedCatalog;
- (void)createHtml;
- (void)outputHtml:(NSString *)outputFilename;

@end
