//
//  ObjectCreater.m
//  DynamicViewGenerator
//
//  Created by Martin on 4/1/15.
//  Copyright (c) 2015 Martin. All rights reserved.
//

#import "ObjectCreater.h"

@implementation ObjectCreater

+ (void) initWithObject:(id) properties inView:(UIView *)view
{
    if ([properties isKindOfClass:[NSArray class]])
    {
        for (id object in properties) {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                id currentObject = [self getUIComponentFromProperties:properties];
                [view addSubview:currentObject];
                if ([self hasSubView:properties]) {
                    NSArray * subViews = [properties valueForKey:@"SubViews"];
                    [self addSubview:subViews inView:currentObject];
                }
            }
        }
    }
    else if ([properties isKindOfClass:[NSDictionary class]])
    {
        id currentObject = [self getUIComponentFromProperties:properties];
        [view addSubview:currentObject];
        if ([self hasSubView:properties]) {
            NSArray * subViews = [properties valueForKey:@"SubViews"];
            [self addSubview:subViews inView:currentObject];
        }
    }
}

#pragma mark - Add Nested View

+ (void) addSubview:(NSArray *) objects inView:(id) view
{
    for (id object in objects) {
        if ([object isKindOfClass:[NSDictionary class]])
        {
            id currentObject = [self getUIComponentFromProperties:object];
            [view addSubview:currentObject];
            if ([self hasSubView:object]) {
                NSArray * subViews = [object valueForKey:@"SubViews"];
                [self addSubview:subViews inView:currentObject];
            }
        }
    }
}

#pragma mark - Helper Methods

+ (id) getUIComponentFromProperties:(NSDictionary *) properties
{
    if ([[properties valueForKey:@"ContainerType"] isEqualToString:@"UIView"])
    {
        return [self viewWithProperties:properties];
    }
    else if ([[properties valueForKey:@"ContainerType"] isEqualToString:@"UILabel"])
    {
        return [self labelWithProperties:properties];
    }
    return nil;
}

+ (UILabel *) labelWithProperties:(NSDictionary *) properties
{
    NSString * rectString = [properties valueForKey:@"Frame"];
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectFromString(rectString)];
    [lbl setBackgroundColor:[self getColorForString:[properties valueForKey:@"BackgroundColor"]]];
    [lbl setText:[properties valueForKey:@"Text"]];
    [lbl setUserInteractionEnabled:[[properties valueForKey:@"UserInterectionAllow"] boolValue]];
    [lbl setEnabled:[[properties valueForKey:@"isEnable"] boolValue]];
    return lbl;
}

+ (UIView *) viewWithProperties:(NSDictionary *) properties
{
    NSString * rectString = [properties valueForKey:@"Frame"];
    UIView * view = [[UIView alloc] initWithFrame:CGRectFromString(rectString)];
    [view setBackgroundColor:[self getColorForString:[properties valueForKey:@"BackgroundColor"]]];
    [view setUserInteractionEnabled:[[properties valueForKey:@"UserInterectionAllow"] boolValue]];
    return view;
}

+ (UIColor *) getColorForString:(NSString *)colorStr
{
    UIColor * color = [UIColor whiteColor];
    if ([colorStr isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([colorStr isEqualToString:@"Yellow"]) {
        color = [UIColor yellowColor];
    } else if ([colorStr isEqualToString:@"Green"]) {
        color = [UIColor greenColor];
    } else if ([colorStr isEqualToString:@"White"]) {
        color = [UIColor whiteColor];
    } else if ([colorStr isEqualToString:@"Grey"]) {
        color = [UIColor grayColor];
    }
    return color;
}

+ (BOOL) hasSubView:(NSDictionary *) properties
{
    if ([[properties valueForKey:@"ContainerType"] isEqualToString:@"UIView"])
    {
        if ([[properties valueForKey:@"SubViews"] isKindOfClass:[NSArray class]])
        {
            if ([[properties valueForKey:@"SubViews"] count] > 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end
