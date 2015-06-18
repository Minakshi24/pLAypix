//
//  common.h
//  #pLAypix
//
//  Created by Minakshi on 7/16/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#ifndef _pLAypix_common_h
#define _pLAypix_common_h

#ifdef DEBUG_MODE
#define DLog( s, ... ) NSLog( @"%@", [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#endif
