//
//  main.m
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatalogParser.h"
#import "CatalogPageCreator.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        NSString *inputFileName;
        NSString *outputFileName;
        
        // there's always an argv[0] which contains path of binary
        if(argc > 1) {
            inputFileName = [NSString stringWithUTF8String:argv[1]];
            // if second argument, use as output filename
            outputFileName = (argc > 2) ? [NSString stringWithUTF8String:argv[2]] : @"default.html";
        } else { // no input file name, show usage, return 1
            printf("\nUsage: CarboniteXML inputfile.xml [outputfile.html]\n");
            exit(1);
        }
        
        // read in the file and start the NSXMLParser
        NSMutableArray *loadedCatalog = [[[CatalogParser alloc] init] loadCatalog:inputFileName];
        // designated initializer pattern, create the page creator and load in the catalog array
        CatalogPageCreator *pageCreator = [[CatalogPageCreator alloc] initWithCatalog:loadedCatalog];
        // encapsulating all the string generation and file output to this class
        [pageCreator createHtml];
        [pageCreator outputHtml:outputFileName];
    }
    return 0;
}
