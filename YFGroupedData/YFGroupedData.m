//
//  YFMetroListBoxData.m
//  YFMetroListBox
//
//  Created by admin on 16/5/26.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import "YFGroupedData.h"

@implementation YFGroupedData

#define kDistinguishString @"0"
#define kNumberSign @"#"
#define kSymbolSign @"✿"
#define kAllIndexArray @[kNumberSign, @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",kSymbolSign]


//获取IndexArray数组
+(NSArray *)getIndexArray:(NSArray *)array{
    NSMutableArray *indexArray = [NSMutableArray array];
    
    NSArray *headerArray = [self getFirstLetterArray:array];
    
    for (int i = 0; i < kAllIndexArray.count; i++) {
        for (int j = 0; j < headerArray.count; j++) {
            if([kAllIndexArray[i] isEqualToString:headerArray[j]]){
                [indexArray addObject:headerArray[j]];
                break;
            }
        }
    }
    
    return indexArray;
}

+(NSArray *)getGroupedArray:(NSArray *)array{
    
    NSMutableArray *numberArray = [NSMutableArray array];
    NSMutableArray *alphabetArray = [NSMutableArray array];
    NSMutableArray *symbolArray = [NSMutableArray array];

    for (int i = 0; i < array.count; i++) {
        if([array[i] startWithNumber]){
        //#数字 number
            [numberArray addObject:array[i]];
        }else if([array[i] startWithChinese]
                 || [array[i] startWithEnglish]){
            [alphabetArray addObject:array[i]];
        }else{
        //@其他 other
            [symbolArray addObject:array[i]];
        }
    }
    
    NSMutableArray *groupedArray = [NSMutableArray array];
    
    //数字 number
    if(numberArray.count > 0){
        [groupedArray addObject:[numberArray sortedArrayUsingFunction:normalSort context:NULL]];
    }//中英文 english or chinese
    if(alphabetArray.count > 0){
        NSArray *indexArray = [self getIndexArray:alphabetArray];
        NSArray *headerArray = [self getFirstLetterArray:alphabetArray];
        for (int i = 0; i < indexArray.count; i++) {
            NSMutableArray *alphaArray = [NSMutableArray array];
            for (int j = 0; j < alphabetArray.count; j++) {
                NSString *headString = headerArray[j];
                if([[headString uppercaseString] isEqualToString:indexArray[i]]){
                    [alphaArray addObject:alphabetArray[j]];
                }
            }
            [groupedArray addObject:[alphaArray sortedArrayUsingFunction:cnAndEnSort context:NULL]];
        }
    }
    //符号 symbol
    if(symbolArray.count > 0){
        [groupedArray addObject:[symbolArray sortedArrayUsingFunction:normalSort context:NULL]];
    }
    return groupedArray;
}


+(NSArray *)getGroupedDictionaryArray:(NSArray *)array{
    NSMutableArray *groupedDictionaryArray = [NSMutableArray array];
    
    NSArray *indexArray = [self getIndexArray:array];
    NSArray *groupedArray = [self getGroupedArray:array];
    
    for (int i = 0; i < indexArray.count; i++) {
        NSMutableDictionary *groupedDictionary = [NSMutableDictionary dictionary];
        [groupedDictionary setObject:groupedArray[i] forKey:indexArray[i]];
        [groupedDictionaryArray addObject:groupedDictionary];
    }
    return groupedDictionaryArray;
}


+(NSArray *)getGroupedDictionaryArray:(NSArray *)array
                             indexKey:(NSString *)indexKey
                             arrayKey:(NSString *)arrayKey{
    NSMutableArray *groupedDictionaryArray = [NSMutableArray array];
    
    NSArray *indexArray = [self getIndexArray:array];
    NSArray *groupedArray = [self getGroupedArray:array];
    
    for (int i = 0; i < indexArray.count; i++) {
        NSMutableDictionary *groupedDictionary = [NSMutableDictionary dictionary];
        [groupedDictionary setObject:groupedArray[i] forKey:arrayKey];
        [groupedDictionary setObject:indexArray[i] forKey:indexKey];
        
        [groupedDictionaryArray addObject:groupedDictionary];
    }
    return groupedDictionaryArray;
}




#pragma mark sort
NSInteger normalSort(id string1, id string2, void *context){
    NSString *str1 = (NSString *)string1;
    NSString *str2 = (NSString *)string2;

    NSComparisonResult result = [str1 localizedCompare:(NSString*)str2];
    return result;
}

NSInteger cnAndEnSort(id string1, id string2, void *context){
    NSString *str1 = [(NSString*)string1 changeToEnglishOrChinese];
    NSString *str2 = [(NSString*)string2 changeToEnglishOrChinese];
    NSComparisonResult result = [str1 localizedCompare:(NSString*)str2];
    return result;
}

+(NSArray *)getFirstLetterArray:(NSArray *)array{
    NSMutableArray *firstLetterArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString * str, NSUInteger idx, BOOL * _Nonnull stop) {
        [firstLetterArray addObject:[[str getFirstLetter] uppercaseString]];
    }];
    return firstLetterArray;
}

@end



@implementation NSString (YFGroupedData)

#pragma 判断
-(BOOL)startWithChinese{
    if(self.length == 0){
        return NO;
    }
    NSString *firsetStr = [self substringToIndex:1];
    NSString *chineseOrEnglishRegex = @"[\u4e00-\u9fa5]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseOrEnglishRegex];
    return [predicate evaluateWithObject:firsetStr];
}

-(BOOL)startWithEnglish{
    if(self.length == 0){
        return NO;
    }
    NSString *firsetStr = [self substringToIndex:1];
    NSString *chineseOrEnglishRegex = @"[a-zA-Z\\s]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseOrEnglishRegex];
    return [predicate evaluateWithObject:firsetStr];
}

-(BOOL)startWithNumber{
    if(self.length == 0){
        return NO;
    }
    NSString *firsetStr = [self substringToIndex:1];
    NSString *chineseOrEnglishRegex = @"[0-9]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseOrEnglishRegex];
    return [predicate evaluateWithObject:firsetStr];
}

#pragma mathod
-(NSString *)changeToEnglishOrChinese{
    NSString *alphabet;
    if([self startWithChinese]){
        //1.中文
        alphabet= [self transformToPinyin];
    }else{
        //2.英文 Make Sure English is always infront of Chinese.
        //变为0+本身；这样就能保证在最前面了
        alphabet = [kDistinguishString stringByAppendingString:self];
    }
    return alphabet;
}


-(NSString *)transformToPinyin{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    return mutableString;
}

- (NSString *)getFirstLetter{
    if([self startWithNumber]){
        //#数字 number
        return kNumberSign;
    }else if([self startWithChinese] || [self startWithEnglish]){
       
            NSString *string = [self changeToEnglishOrChinese];
            NSString *firstLetter = [string hasPrefix:kDistinguishString] ? [string substringWithRange: NSMakeRange(kDistinguishString.length, 1)] : [string substringToIndex:1];
            return firstLetter;
     }else{
        //@其他 other
         return kSymbolSign;
    }
}
@end
