# 购物车API

## 需求
### 订单结算API服务

1. 订单确认（带优惠券计算/用了哪些/可用/不可用）

2. 下单（消耗优惠券）

3. 订单详情（记录优惠券信息）


### 买家

1. 领取优惠券

2. 查看用户优惠券实例列表（个人中心）

3. 查看店铺优惠券模版列表

### 商家

1. 创建优惠券模版

2. 优惠券模版列表

3. 获取优惠券模版详情

4. 获取优惠券使用/领取日志

5. 作废优惠券模版(暂不实现)

6. 作废优惠券实例(暂不实现)

7. 发放优惠券（暂不实现）


## 规则理解
1. overlay true（可以叠加）
   * 每满  thresholdAmount 优惠 discountAmount   
     * StepAmountSettlementConsumeRule amount = thresholdAmount
     * RewardBenefitRule amount = discountAmount
  
   * maxDiscountAmount 优惠金额上限（最多减xxx）
     * CeilBenefitRule（封顶规则） amount = maxDiscountAmount
  
2. overlay false
   * 满 thresholdAmount 优惠 discountAmount 
     * AmountSettlementConsumeRule amount = thresholdAmount
     * RewardBenefitRule amount = discountAmount


## 优惠券基础服务
1. 必须存在的规则
   * TAKE_TIME
   * CONSUME_TIME
   * CONSUME_RANGE


## TODO
1. 如何从session中获取用户信息。
2. 如果基础服务报错，应用层服务会中断。
3. quota 不能为0
4. 异常处理没有完成
