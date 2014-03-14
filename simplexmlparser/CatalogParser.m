//
//  CatalogParser.m
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import "CatalogParser.h"
#import "CD.h"

@interface CatalogParser()

// in this example keeping the array of objects here, see readme
@property (strong, nonatomic) NSMutableArray *catalog;

// simple class used to store information about each CD
@property (strong, nonatomic) CD *cd;

// because I'm using a SAX parser I need to track which element I'm on.
@property (strong, nonatomic) NSString *currentElement;

// because I'm using a SAX parser, it may stop parsing a value at whitespace
// I need to keep concantenating characters until the end of the element
@property (strong, nonatomic) NSMutableString *currentValue;

@end

@implementation CatalogParser

// This is the main jumping off point for this class.
// I read in the file and and kick off the parser, setting this class as the delegate class.
- (NSMutableArray *)loadCatalog:(NSString *)inputFileName
{
    // if file exists and is readable, read in file
    NSData  *fileContents;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // check for file existance and readability
    if ([fileManager fileExistsAtPath:inputFileName] && [fileManager isReadableFileAtPath:inputFileName]) {
        fileContents = [fileManager contentsAtPath:inputFileName];
    } else {
        printf("\nEither this file doesn't exist or you don't have read permissions. \n");
        exit(1);
    }
    
    // if there appears to be something in the file
    if (fileContents) {
        // parse XML into array of objects
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:fileContents];
        // set this class as the class receiving the requests for the delegate methods
        [parser setDelegate:self];
        // kick off the parsing
        [parser parse];
    } else {
        printf("\nThis file appears to be empty. \n");
        exit(1);
    }
    // return the array of CD objects.
    return _catalog;
}

// Below here are some of the delegate methods available from the NSXMLParserDelegate protocol
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    // let the user know parsing has begun.
    printf("Reading in catalog...\n");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // track the element you are currently reading in
    _currentElement = elementName;
    
    // lazy instantiate catalog
    if ( [elementName isEqualToString:@"CATALOG"]) {
        if (!_catalog) {
            _catalog = [[NSMutableArray alloc] init];
        }
        return;
    }
    // lazy instantiate cd
    if ( [elementName isEqualToString:@"CD"]) {
        if (!_cd) {
            _cd = [[CD alloc] init];
        }
        return;
    }
    // lazy instantiate currentValue
    if (!_currentValue) {
        _currentValue = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // every time the delegate method foundCharacters is called, concantenate the new string to the old one.
    [_currentValue appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // if this is the end of the CD element add the created object to the catalog array
    // set cd == nil/null so it's ready for the next CD
    if ( [elementName isEqualToString:@"CD"]) {
        [_catalog addObject:_cd];
        _cd = nil;
        return;
    }
    
     // I know this isn't elegant, but Obj-C doesn't have a switch that works with strings. :/
     // update the individual values for each CD property.
     if ([_currentElement isEqualToString:@"TITLE"]) {
         _cd.title = _currentValue;
     } else if ([_currentElement isEqualToString:@"ARTIST"]) {
         _cd.artist = _currentValue;
     } else if ([_currentElement isEqualToString:@"COMPANY"]) {
         _cd.company = _currentValue;
     } else if ([_currentElement isEqualToString:@"COUNTRY"]) {
         _cd.country = _currentValue;
     } else if ([_currentElement isEqualToString:@"PRICE"]) {
         _cd.price = _currentValue;
     } else if ([_currentElement isEqualToString:@"YEAR"]) {
         _cd.year = _currentValue;
     }
    
    // set the currentElement and currentValue properties to nil/null for next element.
    _currentElement = nil;
    _currentValue = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    // give the user feedback to show how many items have been read in, and that parsing seems to have completed successfully.
    printf("Finished reading in catalog: %lu items.\n", (unsigned long)[_catalog count]);
}

#pragma mark Error Handling
// this is some generic error handling. If this class was used with a UI this information
// could be used to update the UI with appropriate user feedback, and next actions.
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"XMLParser error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    NSLog(@"XMLParser error: %@", [validationError localizedDescription]);
}

@end
