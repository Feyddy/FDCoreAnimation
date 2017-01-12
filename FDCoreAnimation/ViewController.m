//
//  ViewController.m
//  FDCoreAnimation
//
//  Created by 徐忠林 on 12/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

/*
 1、Core Animation(核心动画)是一组功能强大、效果华丽的动画API，无论在iOS系统或者在你开发的App中，都有大量应用。
 
 2、核心动画作用在CALayer（Core animation layer）上，CALayer从概念上类似UIView，我们可以将UIView看成是一种特殊的CALayer（可以响应事件）。
 
 3、核心动画和UIView动画的对比：UIView动画可以看成是对核心动画的封装，和UIView动画不同的是，通过核心动画改变layer的状态（比如position），动画执行完毕后实际上是没有改变的（表面上看起来已改变）。
 
 　　总体来说核心动画的优点有：
 　　1）性能强大，使用硬件加速，可以同时向多个图层添加不同的动画效果
 　　2）接口易用，只需要少量的代码就可以实现复杂的动画效果。
 　　3）运行在后台线程中，在动画过程中可以响应交互事件（UIView动画默认动画过程中不响应交互事件）。
 
 
 4、核心动画类中可以直接使用的类有：
 
 CABasicAnimation
 CAKeyframeAnimation
 CATransition
 CAAnimationGroup
 CASpringAnimation
 */

//6、
//CABasicAnimation和CAKeyframeAnimation属于CAPropertyAnimation的子类
//（1）、初始化
//    + (instancetype)animation;
//    + (instancetype)animationWithKeyPath:(nullable NSString *)path;


//（2）、设置相关属性：
/*
 duration：动画的持续时间
 repeatCount：动画的重复次数
 fillMode：视图在非Active时的行为
 beginTime：动画延迟执行时间（通过CACurrentMediaTime() + your time 设置）
 delegate：代理
 timingFunction:动画的时间节奏控制
 kCAMediaTimingFunctionLinear 匀速
 kCAMediaTimingFunctionEaseIn 慢进
 kCAMediaTimingFunctionEaseOut 慢出
 kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
 kCAMediaTimingFunctionDefault 默认值（慢进慢出）
 */


//（3）、设置keyPath：可以指定keyPath为CALayer的属性值，并对它的值进行修改，以达到对应的动画效果，需要注意的是部分属性值是不支持动画效果的。
//    ani setKeyPath:<#(NSString * _Nullable)#>
/*
 //CATransform3D Key Paths : (example)transform.rotation.z
 
 //rotation 旋轉
 rotation.x
 rotation.y
 rotation.z
 //scale 缩放
 scale.x
 scale.y
 scale.z
 //translation 平移
 translation.x
 translation.y
 translation.z
 
 //CGPoint Key Paths : (example)position.x
 x
 y
 
 //CGRect Key Paths : (example)bounds.size.width
 
 //origin
 origin.x
 origin.y
 
 //size
 size.width
 size.height
 
 //opacity
 backgroundColor
 cornerRadius
 borderWidth
 contents
 
 //Shadow Key Path:
 shadowColor
 shadowOffset
 shadowOpacity
 shadowRadius
 */

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *centerShow;

@property (nonatomic, strong) UIView *cartCenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.centerShow = [[UIView alloc] initWithFrame:CGRectMake(30, 80, 200, 40)];
    self.centerShow.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.centerShow];
    
    self.cartCenter = [[UIView alloc] initWithFrame:CGRectMake(30, 500, 200, 40)];
    self.cartCenter.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.cartCenter];
    
    
//    [self CABasicAnimation];
    
    
//    [self CAKeyframeAnimationWithValue];
//    [self CAKeyframeAnimationWithPath];
    
//    [self CASpringAnimation];
    
    
//    [self CAAnimationGroup];
    
    //关于CATransition的详细使用可以详见demo：https://github.com/Feyddy/FDPushAnimation.git
    [self CATransition];
    
}

#pragma mark - CABasicAnimation
/*
 CABasicAnimation可以设定keyPath的起点，终点的值，动画会沿着设定点进行移动，CABasicAnimation可以看成是只有两个关键点的特殊的CAKeyFrameAnimation。
 */
- (void) CABasicAnimation {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.toValue = [NSValue valueWithCGPoint:self.centerShow.center];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenter.layer addAnimation:ani forKey:@"PostionAni"];
}

#pragma mark - CAKeyframeAnimation
/*
 UIView的关键帧动画就是在CAKeyframeAnimation上封装得来的
 CAKeyframeAnimation的重要属性：
 　　values：关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间段内，依次执行数组中每一个关键帧的动画。
 　　path：动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position。
 　　keyTimes：设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
 */
- (void)CAKeyframeAnimationWithValue {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(150, 200)];
    ani.values = @[value1, value2, value3, value4, value5];
    [self.centerShow.layer addAnimation:ani forKey:@"PostionKeyframeValueAni"];
}

- (void)CAKeyframeAnimationWithPath {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(130, 200, 100, 100));
    ani.path = path;
    CGPathRelease(path);
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    [self.centerShow.layer addAnimation:ani forKey:@"PostionKeyframePathAni"];
}



#pragma mark - CASpringAnimation
/*
 　CASpringAnimation是iOS9新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画。
 
 CASpringAnimation和UIView的SpringAnimation对比：
 
 　　1.CASpringAnimation 可以设置更多影响弹簧动画效果的属性，可以实现更复杂的弹簧动画效果，且可以和其他动画组合。
 　　2.UIView的SpringAnimation实际上就是通过CASpringAnimation来实现。
 
 CASpringAnimation的重要属性：
 
 　　mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
 　　stiffness：弹性系数（弹性系数越大，弹簧的运动越快）
 　　damping：阻尼系数（阻尼系数越大，弹簧的停止越快）
 　　initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
 　　settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
 */
- (void)CASpringAnimation {
    CASpringAnimation * ani = [CASpringAnimation animationWithKeyPath:@"position"];
    ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 5000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    ani.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    ani.initialVelocity = 5.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    ani.duration = 1.f;
    ani.toValue = [NSValue valueWithCGRect:self.centerShow.bounds];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenter.layer addAnimation:ani forKey:@"position"];
}


#pragma mark - CAAnimationGroup
/*
 使用Group可以将多个动画合并一起加入到层中，Group中所有动画并发执行，可以方便地实现需要多种类型动画的场景。
 */
- (void)CAAnimationGroup {
    CABasicAnimation * posAni = [CABasicAnimation animationWithKeyPath:@"position"];
    posAni.toValue = [NSValue valueWithCGPoint:self.centerShow.center];
    
    CABasicAnimation * opcAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcAni.toValue = [NSNumber numberWithFloat:1.0];
    opcAni.toValue = [NSNumber numberWithFloat:0.7];
    
    CABasicAnimation * bodAni = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bodAni.toValue = [NSValue valueWithCGRect:self.centerShow.bounds];
    
    
    CAAnimationGroup * groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[posAni, opcAni, bodAni];
    groupAni.duration = 1.0;
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenter.layer addAnimation:groupAni forKey:@"groupAni"];
}




#pragma mark - CATransition
/*
  转场动画，比UIVIew转场动画具有更多的动画效果，比如Nav的默认Push视图的效果就是通过CATransition的kCATransitionPush类型来实现。
 
 
 CATransition 属性
 type：过渡动画的类型
 
 NSString * const kCATransitionFade;//渐变
 NSString * const kCATransitionMoveIn;//移入
 NSString * const kCATransitionPush;//平移（暂且这么称呼吧）
 NSString * const kCATransitionReveal;//显露
 
 私有API
 @"cube"//立方体
 @"suckEffect"// 吸走的效果
 @"oglFlip"//前后翻转效果
 @"rippleEffect"//110波纹效果
 @"pageCurl"//101翻页起来
 @"pageUnCurl"//102翻页下来
 @"cameraIrisHollowOpen "//107//镜头开
 @"cameraIrisHollowClose "//106镜头关
 subtype： 过渡动画的方向
 
 NSString * const kCATransitionFromRight;
 NSString * const kCATransitionFromLeft;
 NSString * const kCATransitionFromTop;
 NSString * const kCATransitionFromBottom;
 */

- (void)CATransition {
    CATransition * ani = [CATransition animation];
    ani.type = kCATransitionFade;
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 1.5;
    self.centerShow.backgroundColor = [UIColor blueColor];
    [self.centerShow.layer addAnimation:ani forKey:@"transitionAni"];
}

@end
