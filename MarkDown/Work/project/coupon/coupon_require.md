# 优惠券

## 需求分析
### 优惠券基本信息：
1. 用户类型：普通券、新人券
2. 优惠类型：满减券，打折券，现金券，运费券，以及兑换券等等
3. 优惠券名称： 根据活动参与的时间段或者目的的不同，根据具体活动情况直接设置优惠券活动名称，以便区分不同类型的优惠券，也更易于活动的管理。
4. 发放总量： 即发行量，此活动计划发放的优惠券总数量。
5. 使用门槛： 此处以满减券为例，需要设置优惠券满减使用门槛。
6. 优惠内容： 即优惠券面值。
7. 用券时间：即优惠券的有效使用时间，用券时间有2种形式：
   * 绝对时间：即设置具体的固定时间段
   * 相对时间：即设置领取之日后多少天内使用有效
8. 每人限领次数：每人限领次数
9. 其他活动是否支持参与使用优惠券： 当平台有多种促销模式时，必然会出现互斥和叠加的情况，一般情况下相同类型的促销模式互斥，不同类型的促销模式可叠加。
10. 活动商品设置： 全部商品可用，指定商品可用以及指定商品不参与

### 优惠券活动状态：
优惠券活动的状态有：
* 未提交：已经编辑，但是未提交
* 未开始：物理时间未到活动开始时间
* 进行中： ...
* 已结束: ...
* 已终止: 强制终止活动

### 优惠券的发放
* 主动领取：用户自己手动点击领取的情况，
* 被动领取：系统主动发送给用户，

## 数据模型

## 设计与实现


## 语法问题：
### CouponTemplateServiceImpl
1. categoryCouponTemplates.groupBy { it.categoryId!! }.mapValues { it -> it.value.map { it2 -> it2.couponTemplateId!! } }
2. 221 couponTemplateMap[it2]!![0]
3. 540  var canTakes = couponTemplates.filterIndexed { i, _ -> reasons[i] == null }


## API
### Coupon
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

#### router
/coupon
1. put 
> CreateCoupon (创建优惠券实例)
```json
// <!-- requst -->
userId: 
couponTemplateId: 

// <!-- response -->
coupon
```

2. get /list/:userId
rsp: []coupon
3. get /list/:shopId
rsp: []coupon
4. post /cursor
5. post /page
6. post /compute

### CouponTemplate
**CouponTemplate**
* id
* shopId : 所属店铺，如果为空则是平台券
* title : 
* description
* rangeLevel : 计算级别 --- 单品券 SKU(0), 店铺券 SHOP(1), 平台券 PLATFORM(2);
* rangeType : 使用范围 --- 无指定 None(0), 指定Sku SKU(1), 指定品类 CATEGORY(2);
* ranges : 使用范围关联的商品/品类... 
* takeRules : 领取规则
* consumeRules : 使用规则
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

**takeRules**
* type:
  1. TimeTakeRule  限制券的领取时间
     * startTime
     * endTime 
  2. ChannelTakeRule  领券渠道规则
     * channels: List<String>
  3. TotalQuotaTakeRule  发券总数
     * total
  4. UserIdsTakeRule  指定用户领取
     * userIds: List<Long>
  5. UserQuotaTakeRule  单用户可领取数量
     * quota

**benefitRules**
* type : 
  1. RewardBenefitRule 满减
     * amount : 优惠金额

**consumeRules**
* type : 
  1. StepAmountSettlementConsumeRule 阶梯满减结算,每满xx减xx,例如:每满100减20
     * amount : 满减门槛
  2. StepCountSettlementConsumeRule 阶梯数量满减结算,每满xx个减xx,例如:每满2个减20
     * count

  
#### router
/couponTemplate
1. put 
> CreateCouponTemplate (创建优惠券模板)
```json
// <!-- requst -->
{ 
"shopId" : "1",
"title" : "test",
"description" : "test",
"takeRules" : {
   "type" : {
      "TimeTakeRule" : {
         "startTime": "1578075041000",
         "endTime": "1604916863000"
      },
      "TotalQuotaTakeRule" : {
         "total" : 100
      },
      "UserQuotaTakeRule" : {
         "userIds" : [1, 2]
      }}},
"consumeRules" : {
   "type" : {
      "StepAmountSettlementConsumeRule": {
         "amount": 100
      }}},
"benefitRules" : {
   "type" : {
      "RewardBenefitRule": {
         "amount": 20
      }}},
}
// <!-- response -->
couponTemplate
```
2. post /:couponTemplateId
3. delete /:couponTemplateId
4. get /list/:shopId
5. post /cursor
6. post /page

```json

```