//
//  NSArray+NSArray_SortChinese.m
//  YGPatrol
//
//  Created by du on 2017/11/3.
//  Copyright © 2017年 huoshuguang. All rights reserved.
//

#import "NSArray+SortChinese.h"
#import "ShopModel.h"
@interface SortChinese:NSObject

@property(strong,nonatomic)NSString *chinese;
@property(strong,nonatomic)NSString *pinyin;
@property(strong,nonatomic)ShopModel *shop;
@end

@implementation SortChinese
@end

@implementation NSArray (NSArray_SortChinese)

-(NSArray *)sortChinese
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.count; i ++)
    {
        SortChinese *sort = [SortChinese new];
        ShopModel *shop = (ShopModel *)self[i];
        sort.shop  = shop;
        if (shop.name == nil || shop.name.length == 0) {
            continue;
        }
        sort.pinyin = [self toPinyin:shop.name];
        [array addObject:sort];
    }
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    [array sortUsingDescriptors:sortDescriptors];
    NSMutableArray *sortArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.count; i ++)
    {
        SortChinese *sort = array[i];
        [sortArray addObject:sort.shop];
    }
    return [sortArray copy];
}

-(NSString *)toPinyin:(NSString *)chinese
{
    NSMutableString *mutableString = [NSMutableString stringWithString:chinese];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    mutableString =(NSMutableString *)[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [mutableString copy];
}
@end
