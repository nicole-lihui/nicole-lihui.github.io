```ts
// 新增优惠券模版
POST /merchant/couponTemplate/create

const createCouponTemplateReq = {
  type: 0,               // 满减，折扣，免邮
  amount: 100,           // 面值金额，单位 分
  thresholdAmount: 200,  // 门槛金额，单位 分
  total: 1000,           // 发放总数
  limit: 1,              // 每人限领
  startTime: 1234,       // 开始时间
  endTime: 2314,         // 结束时间
}


// 获取优惠券模版列表
GET /merchant/couponTemplate/list

const couponTemplateModel = {
  id: 111,
  stock: 200,            // 当前库存
  status: 0,             // 当前状态，进行中，未开始，已过期

  ...createCouponTemplateReq,
}

GET /merchant/coupon/history




// 获取优惠券列表
GET /coupon/list

const couponModel = {
  id: 111,
  type: 1,
  status: 0,             // 未使用，已使用，已过期
  startTime: 123,
  endTime: 1234,
  amount: 5,
  thresholdAmount: 20,

  shop: { ...shopModel },
}


// 领取优惠券
GET /coupon?id=123
```