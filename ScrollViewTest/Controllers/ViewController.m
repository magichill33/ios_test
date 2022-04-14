//
//  ViewController.m
//  ScrollViewTest
//
//  Created by liuyi on 2022/4/13.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)scroll:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内容区大小
    self.scrollView.contentSize = self.imgView.frame.size;
    self.scrollView.showsVerticalScrollIndicator = NO;
}


- (IBAction)scroll:(id)sender {
    CGPoint point = self.scrollView.contentOffset;
    point.x += 150;
    point.y += 300;
//    self.scrollView.contentOffset = point;
    [self.scrollView setContentOffset:point animated:YES];
}
@end
