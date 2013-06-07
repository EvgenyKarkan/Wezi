

#import "GradientView.h"

#define GRADIENT_COLOR_1    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1.0] CGColor]
#define GRADIENT_COLOR_2    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1.0] CGColor]
#define GRADIENT_COLOR_3    [[UIColor colorWithRed:(arc4random() % 256/256.0) green:(arc4random()% 256/256.0) blue:(arc4random()% 256/256.0) alpha:1.0] CGColor]

@implementation GradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (void)awakeFromNib
{
    CAGradientLayer *gradientLayer  = (CAGradientLayer *)self.layer;
        
    gradientLayer.colors            = @[(id)GRADIENT_COLOR_1,(id)GRADIENT_COLOR_2, (id)GRADIENT_COLOR_3];
    
   }

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    return color;
}

@end
