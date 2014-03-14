//
//  CatalogPageCreator.m
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import "CatalogPageCreator.h"
#import "CD.h"

@interface CatalogPageCreator()

// private var for keeping array of catalog items
@property (strong, nonatomic) NSMutableArray *catalog;

// private var for keeping generated HTML
@property (strong, nonatomic) NSString *page;

@end

@implementation CatalogPageCreator

// this is where I put a "blank" html 5 template. I used the convention of %VAR% as locations for string substitutions.
const NSString *BLANK_HTML = @"<!DOCTYPE html><html lang='en'><head><meta charset='utf-8' /><title>%TITLE%</title></head><body>%BODY%</body></html>";

// this is the designated initializer for this class. simply loads in the array of CD objects.
- (instancetype)initWithCatalog:(NSMutableArray *)loadedCatalog
{
    self = [super init];
    
    if (self) {
        _catalog = loadedCatalog;
    }
    
    return self;
}

// this method contains all the string manipulation for generation of the HTML output.
- (void)createHtml
{
    NSString *title = @"Simple XML Parser";
    NSString *table = @"<h1>Simple XML Parser</h1><table border='1' cellpadding='4'><tr><th>Title</th><th>Artist</th><th>Company</th><th>Country</th><th>Price</th><th>Year</th></tr>%DATA%</table>";
    
    // This section loops through the array of objects to generate the table output.
    NSMutableString *data = [[NSMutableString alloc] init];
    for (CD *item in _catalog) {
        [data appendFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td></tr>",
            item.title, item.artist, item.company, item.country, item.price, item.year];
    }
    
    // simple string substitutions used to put generated string in place.
    NSString *html1 = [BLANK_HTML stringByReplacingOccurrencesOfString:@"%TITLE%" withString:title];
    NSString *table1 = [table stringByReplacingOccurrencesOfString:@"%DATA%" withString:data];
    
    // save final version of string into class var for use in output.
    // of course this would be impractical if the XML was beyond a certain size, see readme.
    _page = [html1 stringByReplacingOccurrencesOfString:@"%BODY%" withString:table1];
}

// create a blank file, if that works, put in the HTML string.
- (void)outputHtml:(NSString *)outputFilename
{
    NSFileManager *fm = [NSFileManager defaultManager];
    // both creates file and returns BOOL if successful.
    if ([fm createFileAtPath:outputFilename contents:nil attributes:nil]) {
        // output HTML string to file.
        [_page writeToFile:outputFilename atomically:YES encoding:NSUTF8StringEncoding error:nil];
        // give feedback of successful writing.
        printf("Wrote output to file: %s \n", [outputFilename UTF8String]);
    } else {
        // give feedback of problem writing to file. again would be used for UI purposes if that existed.
        printf("Error writing file: make sure you have correct permissions. \n");
        exit(1);
    }
}

@end
