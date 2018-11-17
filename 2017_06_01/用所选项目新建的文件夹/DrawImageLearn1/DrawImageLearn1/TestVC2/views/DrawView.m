
#import "DrawView.h"
#import "Dot.h"

@implementation DrawView

@synthesize dots;

- (NSMutableArray *)dots {
	if(nil == dots) {
		self.dots = [NSMutableArray array];
	}
	return dots;
}

//START:code.DrawView.touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	Dot *dot = [[Dot alloc] init];
	dot.x = location.x;
	dot.y = location.y;
	//[self.dots removeAllObjects];
	[self.dots addObject:dot];
	[self setNeedsDisplay];
}
//END:code.DrawView.touchesBegan

//START:code.DrawView.touchesMoved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	Dot *dot = [[Dot alloc] init];
	dot.x = location.x;
	dot.y = location.y;
	[self.dots addObject:dot];
	[self setNeedsDisplay];
}
//END:code.DrawView.touchesMoved

//START:code.DrawView.drawRect
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
	for(Dot *dot in self.dots) {
		CGContextAddArc(ctx, dot.x, dot.y, 5.0f, 0.0f, 2.0f * M_PI, YES);
		CGContextFillPath(ctx);
	}
	
}
//END:code.DrawView.drawRect

- (void)dealloc {
	self.dots = nil;
//	[super dealloc];
}


@end
