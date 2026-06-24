---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/design-for-extremes-nielsen.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: design-for-extremes-nielsen
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
---

# P95/P50 Ratio: 평균 사용자를 위한 설계의 오류

디지털 제품 설계 시 '평균 사용자'를 타겟하는 것은 오류이다. 디지털 사용량은 물리 세계의 정규분포와 달리 **power law(멱법칙)**을 따르며, 평균값은 실제 존재하지 않는 "Mathematical Ghost"이다 ^[design-for-extremes-nielsen.md].

## 핵심 지표: P95/P50 Ratio
*   **P50 (중앙값)**: 전체 사용자의 절반이 이보다 적게 사용 ^[design-for-extremes-nielsen.md].
*   **P95 (상위 5%)**: 헤비유저. 종종 비즈니스 가치의 대부분을 생성하나, 항상 고가치는 아님(별도 검증 필요) ^[design-for-extremes-nielsen.md].
*   **비율**: 도메인에 따라 P95/P50 ratio가 **3x ~ 100x+**로 크게 차이남 ^[design-for-extremes-nielsen.md].

## 설계 원칙 및 재사용 패턴
1.  **동시 설계**: P50 사용자의 단순 니즈와 P95 사용자의 집약적 요구를 **동시에** 만족시켜야 함. "평균"을 타겟하면 양쪽 모두를 놓침 ^[design-for-extremes-nielsen.md].
2.  **경로 분리**: 앱 설계 시 캐주얼 "관광객"과 파워유저를 별도 경로로 처리 ^[design-for-extremes-nielsen.md].
3.  **기능 우선순위**: P95가 필요로 하는 기능이 P50에게는 불필요할 수 있으며, 그 반대도 성립함 ^[design-for-extremes-nielsen.md].
4.  **메트릭 변경**: 평균 DAU/세션 길이 대신 **percentile 분포**를 확인 ^[design-for-extremes-nielsen.md].

## 관련 맥락
*   Rob Pike의 5규칙(측정 없는 최적화 금지) 및 제약 이론(병목은 예상 못한 곳에 발생)과 유사한 맥락 ^[design-for-extremes-nielsen.md].
