//
//  AnnouncementCell.m
//  实用的分页滑动
//
//  Created by Apollo on 17/6/14.
//  Copyright © 2017年 Apollo. All rights reserved.
//

#import "AnnouncementCell.h"
#import "NoticeModel.h"
#import "NSDate+LCExtend.h"
@interface AnnouncementCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *TypleImage;

@end

@implementation AnnouncementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(NoticeModel *)model
{
    _model = model;
    
    //设置dateLabel
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    NSDate *createdDate;
    if (_model.xnotice_date.length>0) {
        createdDate = [formatter dateFromString:_model.xnotice_date];
    }
  
    if (createdDate.isToday) {
        if (createdDate.deltaToNow.hour>=1) {
            self.self.data.text= [NSString stringWithFormat:@"%ld小时前",createdDate.deltaToNow.hour];
        }else if(createdDate.deltaToNow.minute>=1){
            self.self.data.text=  [NSString stringWithFormat:@"%ld分钟前",createdDate.deltaToNow.minute];
        }else{
            self.self.data.text=  @"刚刚";
        }
    }else if (createdDate.isYesterday){
        formatter.dateFormat=@"昨天 HH:mm";
        self.data.text=  [formatter stringFromDate:createdDate];
        
    }else if (createdDate.isThisYear){
        
        formatter.dateFormat=@"MM月dd日 HH:mm";
        self.data.text=  [formatter stringFromDate:createdDate];
    }else{
        formatter.dateFormat=@"yyyy-MM-dd HH:mm";
        self.data.text=  [formatter stringFromDate:createdDate];
    }
    
    if (!self.data.text) {
        self.data.text = @"刚刚";
    }
    if ([_model.article_type isEqualToString:@"sLink"]) {
        [self.TypleImage setImage:[UIImage imageNamed:@"链接 (1).png"]];
    }else
    {
        [self.TypleImage setImage:[UIImage imageNamed:@"文章.png"]];
    }
    
    self.title.text = _model.xnotice_title;
    self.name.text = _model.xnotice_content_intro;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
