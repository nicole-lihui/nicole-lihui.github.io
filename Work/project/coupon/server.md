# 优惠券项目业务梳理

## Entity (DTO)
1. CategoryCoupon 
  * id 
  * categoryId
  * couponTemplateId
  * startTime
  * endTime

2. ComputeCoupon  计算优惠券优惠
   * userId
   * items
   * couponIds


3. ComputeCouponItem  计算优惠券结果
  * couponId
  * selected
  * selectable
  * unselectableReason
  * unselectableData

4. ComputeCouponResult 优惠券计算结果
  * coupons : 用户所有优惠券信息
  * benefit : 当前优惠券组合的优惠金额
  * bestCouponIds: 可用的最佳组合优惠券ID
  * bestBenefit: 最佳组合的优惠金额
  * adjusted : 计算后使用的券是否和提交的一致
  * adjustedReason : 计算后使用的券和提交不一致，返回修改原因 
  * adjustedData : 

5. ComputeCouponTemplate 计算可用优惠券模版
   * userId
   * items
  
6. ComputeCouponTemplateItem : 可用优惠券模版信息
   * templateId
   * skuIds : 可以使用该优惠券的sku(单品项管理 Stock Keeping Unit)
   * canTake : 是否可以领取
   * canNotTakeReason : 不可以领取原因
   * canNotTakeData : 不可以领取相关数据
   * canConsume : 是否满足使用条件
   * canNotConsumeReason : 不可使用的原因
   * canConsume : 是否满足使用条件
   * canNotConsumeReason : 不可使用的原因
   * canNotConsumeData : 不可使用的相关的数据
   * benefitAmount : 优惠金额
   * couponIds : 关联的已经领取过的优惠券

7. ComputeItem : 参与优惠券计算的物品
   * productId
   * skuId : 单品id
   * shopId
   * categories : 商品类目
   * type : 商品类型
   * isPresent : 是否赠品
   * num : 数量
   * cost : 成本价
   * price : 原价
   * discountPrice : 优惠后单价
   * finalPrice : 均摊后单价 finalPrice = finalAmount / num
   * discountAmount : 总价优惠金额
   * finalAmount : 最终实际总价 finalAmount = discountPrice * num - discountAmount
   * pointsPrice : 积分兑换单价


8. Coupon 优惠券领取后生成的实例
  * id
  * shopId : 所属店铺，如果为空则是平台券
  * userId : 所属用户
  * templateId : 关联的优惠券模版
  * takeTime : 领取时间
  * startTime : 有效起始时间
  * endTime : 有效结束时间
  * consumed : 是否使用
  * consumeTime : 使用时间
  * ctime
  * mtime

9. CouponTemplate : 优惠券模版
  * id
  * shopId : 所属店铺，如果为空则是平台券
  * title 
  * description
  * rangeLevel : 计算级别 --- 单品券 SKU(0), 店铺券 SHOP(1), 平台券 PLATFORM(2);
  * rangeType : 使用范围 --- 无指定 None(0), 指定Sku SKU(1), 指定品类 CATEGORY(2);
  * ranges : 使用范围关联的商品/品类... 
  * consumeRules : 领取规则
  * benefitRules : 优惠规则
  * startTime : 领取起始时间
  * endTime : 领取结束时间
  * total : 总数量，null表示不限制数量
  * remain : 剩余数量
  * takeCount : 
  * consumedCount : 
  * ctime
  * utime
  * dtime
  * deleted

10 SkuCouponTemplate 单品优惠券模板
  * id
  * skuId
  * couponTemplateId
  * startTime : couponTemplate的领取起始时间,用于快速筛选有效couponTemplateId
  * endTime : couponTemplate的领取结束时间,用于快速筛选有效couponTemplateId


## 业务梳理
### Rest （Controller）
####  优惠券
1. 领取优惠券 couponTemplateService.take

2. 批量领取优惠券 couponTemplateService.batchTake

3. 计算优惠金额,以及可操作优惠券列表 couponService.compute

4. 使用优惠券  
   * couponService.consume
   * couponService.batchRetrieve
   * couponTemplateService.cacheKeyOfCount
   * couponTemplateService.increaseCount(countKeys)

5. 退回优惠券
   * couponService.recover
   * couponService.batchRetrieve
   * couponTemplateService.cacheKeyOfCount
   * couponTemplateService.decreaseCount
   
6. 翻页查询优惠券 couponService.page
   
7. 游标查询优惠券 couponService.cursor

#### 优惠券模板
1. 创建优惠券模版
   * couponTemplateService.create
   * couponTemplateService.retrieve

2. 查询优惠券模版 couponTemplateService.retrieve

3. 批量查询优惠券模版 couponTemplateService.batchRetrieve

4. 删除优惠券模版 couponTemplateService.delete

5. 计算相关items满足的优惠券活动 couponTemplateService.compute

6. 批量翻页查询优惠券模版 couponTemplateService.batchRetrieveByRanges

7. 翻页查询优惠券模版 couponTemplateService.page

#### 优惠券Log
1. 翻页查询优惠券日志 couponLogService.page


### Mapper
#### CouponTemplateMapper
1. selectByPrimaryKey(id)
2. batchRetrieveCandidateCouponTemplates(couponTemplateIds, Date())

#### CouponMapper
1. insertSelective(coupon)
2. batchInsert(coupons)
3. selectByPrimaryKey(coupon.id)
4. batchRetrieve(couponIds)
5. batchRetrieveByUserAndCouponTemplate(compute.userId!!, candidateIds)
6. batchRetrieveConsumedCount(expiresCounts.toList())
7. batchRetrieveTakeCount(expiresCounts.toList())
8. batchRetrieveConsumedCount(expiresCounts.toList())
9. consume(couponIds)
10. recover(couponIds)

#### CouponLogMapper
1. batchInsert(couponLogs)
2. insertSelective(couponLog)


#### SkuCouponTemplateMapper
1. batchInsert(skuCouponTemplates)
2. retrieveByCouponTemplateId(couponTemplate.id!!)
3. batchRetrieveByCouponTemplateIds(couponTemplateIds)
4. selectByExample(example)

#### CategoryCouponTemplateMapper
1. batchInsert(categoryCouponTemplates)
2. retrieveByCouponTemplateId(couponTemplate.id!!)
3. batchRetrieveByCouponTemplateIds(couponTemplateIds)
4. batchRetrieveByCategoryIds(categoryIds)
5. selectByExample(example)

## 难点
1. 规则
2. 计算金额
3. 事务
