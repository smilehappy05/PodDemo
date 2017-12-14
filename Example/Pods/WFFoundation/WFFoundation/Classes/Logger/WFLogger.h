//
//  WLUtility.h
//  Pods
//
//  Created by WuShiHai on 11/04/2017.
//
//

#ifndef WFLogger_h
#define WFLogger_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#endif /* WFLogger_h */
