//
//  ViewController.m
//  CBLayerDemo
//
//  Created by Mike on 2017/5/31.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGPoint startPoint;
    CGPoint angel;//记录x,y轴旋转的角度
    CGFloat framWidth;
    CGFloat framHeight;
    BOOL isCount;
}

//跟视图，用于相应手势
@property (strong, nonatomic) IBOutlet UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    angel = CGPointMake(0, 0);
    
    framWidth = CGRectGetWidth(self.myView.frame);
    framHeight = CGRectGetHeight(self.myView.frame);
    
    [self addLabels];
    
    self.myView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.myView addGestureRecognizer:panGesture];
}

-(void)panGestureAction:(UIPanGestureRecognizer *)gesture{
    
    //标记每次手势开始时的位置
    CGPoint point = [gesture locationInView:self.myView];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        startPoint = point;
        return;
    }
    
    //根据每次手势滑动的距离，计算旋转的角度
    CGFloat angelX = angel.x + (point.x-startPoint.x)/100;
    CGFloat angelY = angel.y - (point.y-startPoint.y)/100;
    
    
    //判断滑动点是否在myView中，如果不在，则只记录第一次超出范围时旋转的角度
    BOOL isContain = CGRectContainsPoint(self.myView.bounds, point);
    if (!isContain) {
        if (!isCount) {
            angel = CGPointMake(angelX, angelY);
            isCount = YES;
        }
        return;
    }
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 0.0001;
    transform = CATransform3DRotate(transform, angelX, 0, 1, 0);
    transform = CATransform3DRotate(transform, angelY, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, 50);
    self.myView.layer.sublayerTransform = transform;
    
    //记录手势结束时，旋转的角度
    if (gesture.state == UIGestureRecognizerStateEnded) {
        angel = CGPointMake(angelX, angelY);
    }
}

-(void)addLabels{
    
    /**
     * 这里使用一个 CATransform3D 也可以，只是要注意的是，每次旋转，坐标系都会跟着一起旋转
     *
     */
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 0.00001;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100, 100)];
    label1.backgroundColor  = [UIColor redColor];
    label1.text = @"1";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:30];
    transform1 = CATransform3DRotate(transform1, 0, 0, 0, 0);
    transform1 = CATransform3DTranslate(transform1, 0, 0, 0);
    label1.layer.transform = transform1;
    [self.myView addSubview:label1];
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = 0.00001;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100,100)];
    label2.backgroundColor  = [UIColor orangeColor];
    label2.text = @"2";
    label2.font = [UIFont systemFontOfSize:30];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.myView addSubview:label2];
    transform2 = CATransform3DRotate(transform2, M_PI_2, 0, 1, 0);
    transform2 = CATransform3DTranslate(transform2, 50, 0, 50);
    label2.layer.transform = transform2;
    
    CATransform3D transform3 = CATransform3DIdentity;
    transform3.m34 = 0.00001;
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100 , 100)];
    label3.backgroundColor  = [UIColor yellowColor];
    label3.text = @"3";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:30];
    transform3 = CATransform3DRotate(transform3, -M_PI_2, 1, 0, 0);
    transform3 = CATransform3DTranslate(transform3, 0, 50, 50);
    label3.layer.transform = transform3;
    [self.myView addSubview:label3];
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4.m34 = 0.00001;
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100 , 100)];
    label4.backgroundColor  = [UIColor blueColor];
    label4.text = @"4";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:30];
    transform4 = CATransform3DRotate(transform4, M_PI_2, 0, 1, 0);
    transform4 = CATransform3DTranslate(transform4, 50, 0, -50);
    label4.layer.transform = transform4;
    [self.myView addSubview:label4];
    
    CATransform3D transform5 = CATransform3DIdentity;
    transform5.m34 = 0.00001;
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100 , 100)];
    label5.backgroundColor  = [UIColor greenColor];
    label5.text = @"5";
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont systemFontOfSize:30];
    transform5 = CATransform3DRotate(transform5, -M_PI_2, 1, 0, 0);
    transform5 = CATransform3DTranslate(transform5, 0, 50, -50);
    label5.layer.transform = transform5;
    [self.myView addSubview:label5];
    
    CATransform3D transform6 = CATransform3DIdentity;
    transform6.m34 = 0.00001;
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(framWidth/2-50, (framHeight-100)/2, 100 , 100)];
    label6.backgroundColor  = [UIColor purpleColor];
    label6.text = @"6";
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = [UIFont systemFontOfSize:30];
    transform6 = CATransform3DRotate(transform6, -M_PI, 1, 0, 0);
    transform6 = CATransform3DTranslate(transform6, 0, 0, 100);
    label6.layer.transform = transform6;
    [self.myView addSubview:label6];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
