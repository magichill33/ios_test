//
//  CarrouselViewController.m
//  ScrollViewTest
//
//  Created by liuyi on 2022/4/14.
//

#import "CarrouselViewController.h"

@interface CarrouselViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *svImage;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CarrouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.svImage.delegate = self;
    int count =  4;
    CGFloat imgW = self.svImage.frame.size.width;
    CGFloat imgH = 220;
    CGFloat imgY = 0;
    for (int i = 0 ; i < count; i++) {
        UIImageView *imageView = [UIImageView new];
        NSString *name = [NSString stringWithFormat:@"item_%02d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        //计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imgW;
        imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        //imageView.contentMode = UIViewContentModeCenter;
        [self.svImage addSubview:imageView];
    }
    
    CGFloat maxW = imgW * count;
    self.svImage.contentSize = CGSizeMake(maxW, 0);
    
    //实现UIScrollView的分页效果
    self.svImage.pagingEnabled = YES;
    //隐藏水平滚动指示器
    self.svImage.showsHorizontalScrollIndicator = NO;
    //设置总页数
    self.pageControl.numberOfPages = count;
    
    [self timerMake];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    int page = offsetX / scrollView.frame.size.width;
    
    //将页码设备给UIPageControl
    self.pageControl.currentPage = page;
    //NSLog(@"滚动了");
}

//实现即将开始时拖拽的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //停止计时器，计时器就不可重用
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新启动一个计时器
    [self timerMake];
}

- (void)scrollImage
{
    //滚动一次图片
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1) {
        //如果已经到达最后已经，回到第一页
        page = 0;
    } else {
        page++;
    }
    CGFloat offsetX = page * self.svImage.frame.size.width;
    [self.svImage setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//定义一个创建定时器的方法
-(void)timerMake
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    //再次修改一下新创建的timer的优先级
    //修改self.timer的优先级与控制一样
    //获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
