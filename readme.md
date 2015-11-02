## 公司评级

该项目为Feigu6期项目,通过各大网站招聘信息给予各个公司一

### 数据说明书

#### 重要变量

- 公司名
- 职位名
- 教育程度需求
- 工作城市
- 搜索来源(51/liepin/..)

#### 不重要变量
- 薪资
- 职位关键词(大数据/hive/hadoop)
- 时间


#### 外部变量

- [2015互联网+O2O服务平台Top100](http://www.enet.com.cn/article/2015/1007/A20151007005673.html)


### 模型步骤

1. 使用HIVE取数,清理变量
2. join外部csv评分文件作为response
3. 训练评分模型(SparkR,pyspark)
4. 预测其他变量的分数(50%模型,50%规则)

### 数据准备

生成变量:

- 公司名 company_name
- city: '北上广杭' big_city
- 公司职位个数 postion_num
- spark职位个数 spark
- hadoop职位个数 hadoop
- 大数据职位个数 bigdata
- spark职位比例 spark_ratio
- hadoop职位比例 hadoop_ratio
- 大数据职位比例 bigdata_ratio
- 高薪数量 high_pay
- 中薪数量 medium_pay
- 低薪数量 low_pay
- 硕士比例 master
- 本科比例 bachelor
- 大专比例 junior

### 模型训练

#### LASSO

- 外部数据训练模型
- 预测得分,归一化处理,分数为0~50

#### 规则得分

- 10%分数为标记分数
- 20%分数为招聘规模得分
- 5%分数为技术比例
- 5%分数为城市分数
- 5%分数为薪资得分
- 5%分数为学历得分


#### pySpark

在Spark平台上,使用MLlib进行lasso建模,并没有再次计算规则分数,主要步骤为:

- 从HIVE中导入数据,保存为DataFrame的形式
- 将DataFrame转化为RDD用于模型的训练
- 预测,并将得到的RDD的结果经过DataFrame存回HIVE中



#### 代码运行

在`script`文件中,运行以下文件,以完成所有计算 

```
sh Main.sh
```

#### 部分结果(仅供参考)

公司 | 得分
---|---
百度	| 80.21854 
滴滴	| 79.55409 
京东	| 78.72889 
上海华点云生物科技有限公司北京分公司	| 77.61970 
上海博辕信息技术服务有限公司 | 77.61970 
携程 | 77.26559 
上海孚聚资产管理有限公司 | 76.26064 
北京四达时代软件技术股份有限公司 | 76.26064 

