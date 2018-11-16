//
//  TestVC1.m
//  UILabel
//
//  Created by xiaoyulong on 16/5/23.
//  Copyright © 2016年 xiaoyulong. All rights reserved.
//

#import "TestVC1.h"
#import "TTTAttributedLabel.h"

@interface TestVC1 () <TTTAttributedLabelDelegate>

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    TTTAttributedLabel *attributedLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 10, 200, 80)];
//    NSString *str = @"Tom Bombadildadjgsudgaudgusdgsudgusdgsudgsudgsudgusdgusgdugdusagudasgduasgudsagudgausdgsudgusdgusdgufgufgsudgsuug";
//    
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:str
//                                                                    attributes:@{
//                                                                                 (id)kCTForegroundColorAttributeName : (id)[UIColor redColor].CGColor,
//                                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
//                                                                                 NSKernAttributeName : [NSNull null],
//                                                                                 (id)kTTTBackgroundFillColorAttributeName : (id)[UIColor greenColor].CGColor
//                                                                                 }];
//    
//    // The attributed string is directly set, without inheriting any other text
//    // properties of the label.
//    attributedLabel.text = attString;
//    [self.view addSubview:attributedLabel];
    
    
    
    
//    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(100, 10, 100, 100)];
//    label.backgroundColor = [UIColor yellowColor];
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor darkGrayColor];
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    label.numberOfLines = 0;
//    
//    // If you're using a simple `NSString` for your text,
//    // assign to the `text` property last so it can inherit other label properties.
//    NSString *text = @"Lorem ipsum dolor sit amet";
//    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"ipsum dolor" options:NSCaseInsensitiveSearch];
//        NSRange strikeRange = [[mutableAttributedString string] rangeOfString:@"sit amet" options:NSCaseInsensitiveSearch];
//        
//        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
//        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
//        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
//        if (font) {
//            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
//            [mutableAttributedString addAttribute:kTTTStrikeOutAttributeName value:@YES range:strikeRange];
//            CFRelease(font);
//        }
//        
//        return mutableAttributedString;
//    }];
//    [self.view addSubview:label];
    
    
    
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(100, 120, 120, 60)];
    label.backgroundColor = [UIColor yellowColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    //设置高亮颜色
    label.highlightedTextColor = [UIColor greenColor];
    
    //检测url
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    //对齐方式
    label.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    
    //行间距
    label.lineSpacing = 8;
    
    //设置阴影
    label.shadowColor = [UIColor grayColor];
    
    label.delegate = self; // Delegate
    //NO 不显示下划线
    label.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    NSString *text = @"冷清风 赞了 王战 的说说";
    
    
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         
         //设置可点击文字的范围
         NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"冷清风" options:NSCaseInsensitiveSearch];
         
         //设定可点击文字的的大小
         UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:16];
         CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
         
         if (font) {
             
             //设置可点击文本的大小
             [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
             
             //设置可点击文本的颜色
             [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blueColor] CGColor] range:boldRange];
             
             CFRelease(font);
             
         }
         return mutableAttributedString;
     }];
    
    //正则
    NSString *parten = @"(\\s)*(\\[)(\\s)*(self)(\\s)*(.)(\\s)*(label)(\\s)*(setText)(\\s)*(:)(\\s)*(@)(\\s)*(\".*\")(\\s)*(\\])(\\s)*(;)(\\s)*";

    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];

    NSRange linkRange = [regexp rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, 3)];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.exiucai.com/"]];
    
    //设置链接的url
    [label addLinkToURL:url withRange:linkRange];
    
    
    [self.view addSubview:label];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    
    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
