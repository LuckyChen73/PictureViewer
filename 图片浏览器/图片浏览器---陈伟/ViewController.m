//
//  ViewController.m
//  图片浏览器---陈伟
//
//  Created by EZ on 16/12/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//上一张按钮属性
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
//下一张按钮属性
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
//索引标签
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
//图片简介标签
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//显示图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;




@end

@implementation ViewController{
    //定义成员变量保存数据
    NSArray *_imageData;
    //索引
    NSUInteger _index;
    
}
//点击上一张按钮方法
- (IBAction)previousBtnClick {
    _index--;
    [self changData];
}
//点击下一张按钮方法
- (IBAction)nextBtnClick {
    _index++;
    [self changData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    //1.加载数据
    _imageData=[self loadData];
    //2.设置数据
    [self changData];
    
}

-(void)changData
{
    //0.根据索引获取当前数组中的字典
    NSDictionary *dic=_imageData[_index];
    
    //1.设置索引,拼接,存储到索引标签的文本中
    self.indexLabel.text=[NSString stringWithFormat:@"%zd / %zd",_index+1,_imageData.count];
    
    //2.设置动画图片
    //2.1创建可变数组保存图片
    NSMutableArray *arrM=[NSMutableArray array];
    //2.2 for循环添加拼接图片名称并加载图片
    //1.获取当前图片个数
    NSInteger imageCount=[dic[@"count"] integerValue];
    //2.根据图片的个数动画for 循环加载图片
    for (NSInteger i=0; i<imageCount; i++) {
        
        //3.拼接图片
        NSString *imageName=[NSString stringWithFormat:@"%@%03zd",dic[@"icon"],i+1];
        //4.加载图片
        UIImage *image=[UIImage imageNamed:imageName];
        //5.把图片添加到可变数组中
        [arrM addObject:image];
    }
    
    //3.生成gif图片
    UIImage *image=[UIImage animatedImageWithImages:arrM duration:arrM.count*0.1];
    
    //4.给imageView设置一张gif图片
    self.imageView.image=image;
    
    //5.设置图片简介
    self.descLabel.text=dic[@"desc"];
    
    //6.设置按钮状态
    //如果index为0,则上一张按钮失效
    self.previousBtn.enabled=_index;
    //如果index为7,则下一张按钮失效
    self.nextBtn.enabled=_imageData.count-_index-1;
    
}

#pragma mark - 加载数据
-(NSArray *)loadData
{
    //1.获取当前app装到模拟器是之后的路径
    NSBundle *bundle=[NSBundle mainBundle];
    //2.获取bundle中指定的文件路径
    NSString *path=[bundle pathForResource:@"images.plist" ofType:nil];
    //3.加载指定的路径的文件,返回一个数组
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    
    
    return arr;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
