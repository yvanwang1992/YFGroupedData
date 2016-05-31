# YFGroupedData
Get grouped data which can be used in UITableView with HeaderView. 
MeanWhile,the array will be grouped as #ABC...Z✿ ordered in ascending order 

"#"      means  number <p/>
"ABC..Z" means  alphabet <p/>
"✿"      means  others <p/>
  

#####[博客园记录: 【IOS】将一组包含中文的数据按照#ABC...Z✿分组](http://www.cnblogs.com/yffswyf/p/5542852.html)

##Effection: 

Alphabet 
<p/>
  ![GroupName](https://github.com/yvanwang1992/YFGroupedData/blob/master/screenshots/pictureTop.png)

HeaderView Label Name
<p/>
  ![AllAlphabet](https://github.com/yvanwang1992/YFGroupedData/blob/master/screenshots/pictureBottom.png)


# How To Use It?

####1.#import "YFGroupedData.h"


####2.Methods<p/>

//@[[@"11",@"32"],@[@"big",@"Boy"],...@[@"zoom",@"zune"]]<p/>
#####+(NSArray *)getGroupedArray:(NSArray *)array;

//@[@"title1",@"title2",...@"titlen"]<p/>
#####+(NSArray *)getIndexArray:(NSArray *)array;


//@[{@"indexKey":@"A",@"arrayKey":@[@"abandon",@"About",@"All"]},
//                    ............                              ,
//@{@"indexKey":@"Z",@"arrayKey":@[@"bean",@"Big",@"boy"]}<p/>
#####+(NSArray *)getGroupedDictionaryArray:(NSArray *)array
##### indexKey:(NSString *)indexKey arrayKey:(NSString *)arrayKey;

//@[{@"A":@[@"abandon",@"About",@"All"]},
//       ......................         ,
//  {@"Z":@[@"bean",@"Big",@"boy"]}]<p/>
#####+(NSArray *)getGroupedDictionaryArray:(NSArray *)array;


Than you can use it.
