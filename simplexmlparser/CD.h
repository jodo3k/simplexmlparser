//
//  CD.h
//  simplexmlparser
//
//  Created by JD Elliott on 3/14/14.
//  Copyright (c) 2014 SomeCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CD : NSObject

// These are the properties for the CD taken from the XML file.
// I left these simple strings since no further functionality was needed than output.
// If additional functionality was required price and year they would probably be NSDecimalNumber and NSUInteger respectively.
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *artist;
@property(strong, nonatomic) NSString *company;
@property(strong, nonatomic) NSString *country;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *year;

@end
