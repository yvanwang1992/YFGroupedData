//
//  YFMetroListBoxData.h
//  YFMetroListBox
//
//  Created by admin on 16/5/26.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFGroupedData : NSObject

//@[[@"11",@"32"],@[@"big",@"Boy"],...@[@"zoom",@"zune"]]
+(NSArray *)getGroupedArray:(NSArray *)array;

//@[@"title1",@"title2",...@"titlen"]
+(NSArray *)getIndexArray:(NSArray *)array;

//@[{@"indexKey":@"A",@"arrayKey":@[@"abandon",@"About",@"All"]},
//                    ............                              ,
//@{@"indexKey":@"Z",@"arrayKey":@[@"bean",@"Big",@"boy"]}
+(NSArray *)getGroupedDictionaryArray:(NSArray *)array
                             indexKey:(NSString *)indexKey
                             arrayKey:(NSString *)arrayKey;

//@[{@"A":@[@"abandon",@"About",@"All"]},
//    ......................     ,
//  {@"Z":@[@"bean",@"Big",@"boy"]}]
+(NSArray *)getGroupedDictionaryArray:(NSArray *)array;

@end





@interface NSString (YFGroupedData)

-(BOOL)startWithChinese;
-(BOOL)startWithEnglish;
-(BOOL)startWithNumber;

-(NSString *)changeToEnglishOrChinese;

-(NSString *)transformToPinyin;

-(NSString *)getFirstLetter;

@end