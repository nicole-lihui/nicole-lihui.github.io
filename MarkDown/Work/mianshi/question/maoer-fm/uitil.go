package utilts

import (
	"math/rand"
)

func ComputeProbabilityOfLottery(m float32, a int) (rate float32) {

	var rateCh = make(chan float32, 10);
	defer close(rateCh)

	for i := 0; i < 1000; i++ {
		go mocklottery(m, a, rateCh);
	}

	var sum float32 = 0
	sum += <- rateCh
	rate = sum / 1000

	return rate
}

func mocklottery(m float32, a int, rateCh chan float32) {
	for i := 0; i < 10000; i++ {
	// 随机数[0, 100]。模拟用户抽中大奖还是小奖。大奖区间 [0, m * 100]; 小奖 [m * 100 + 1, 100]
		result := rand.Int63n(100)
		if result <= int64(m * 100) {
			var rate float32 = float32(i) / float32(10000)
			rateCh <- rate
			return
		}
		if i == a {
			var rate float32 = float32(i) / float32(10000)
			rateCh <- rate
			return
		}
	}
}
