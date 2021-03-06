/*
 * Copyright (C) 2010- Peer internet solutions
 * 
 * This file is part of mixare.
 * 
 * This program is free software: you can redistribute it and/or modify it 
 * under the terms of the GNU General Public License as published by 
 * the Free Software Foundation, either version 3 of the License, or 
 * (at your option) any later version. 
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License 
 * for more details. 
 * 
 * You should have received a copy of the GNU General Public License along with 
 * this program. If not, see <http://www.gnu.org/licenses/>
 */

#import "RadarView.h"
#define radians(x) (M_PI * (x) / 180.0)

@implementation RadarView

@synthesize pois = _pois, range= _range, radius= _radius;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(contextRef, 0, 0, 115, 0.3);
    CGContextSetRGBStrokeColor(contextRef, 0, 0, 125, 0.1);
	
    // Draw a radar and the view port 
    CGContextFillEllipseInRect(contextRef, CGRectMake(0.5, 0.5, RADIUS*2, RADIUS*2)); 
    CGContextSetRGBStrokeColor(contextRef, 0, 255, 0, 0.5);
    
    _range = _radius *1000;
    float scale = _range / RADIUS;
	
    for(PhysicalPlace *poi in self.pois){
		float x = RADIUS + sinf(poi.azimuth) * poi.radialDistance/scale;
		float y = RADIUS - cosf(poi.azimuth) * poi.radialDistance/scale;
		
		//drawing the radar point
		if([poi.source isEqualToString:@"WIKIPEDIA"]){
			CGContextSetRGBFillColor(contextRef, 255, 0, 0, 1);
		}else if([poi.source isEqualToString:@"BUZZ"]){
			CGContextSetRGBFillColor(contextRef, 0, 255, 0, 1);
		}
		if(x <= RADIUS*2 && x>=0 && y>=0 && y <= RADIUS*2){
			CGContextFillEllipseInRect(contextRef, CGRectMake(x,y, 2, 2)); 
		}
	}
	
}


- (void)dealloc {
    [super dealloc];
}


@end
