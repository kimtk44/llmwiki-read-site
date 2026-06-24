---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: 0525-1431_capture_deepseek-v4-kilo-flowgraph-bench
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://blog.kilo.ai/p/we-tested-deepseek-v4-pro-and-flash
---

# DeepSeek V4 Pro/Flash vs Opus 4.7 vs Kimi K2.6 (Kilo FlowGraph Bench)

Kilo.ai의 FlowGraph 워크플로우 오케스트레이션 백엔드(20 endpoint, persistent state, lease 관리 등)를 1-prompt로 빌드한 벤치마크 결과. DeepSeek V4(Pro/Flash)는 Opus 4.7과 Kimi K2.6 대비 점수와 비용 구조에서 명확한 포지셔닝을 보였으며, **재현 기반 검증**을 통해 표면적 구현과 운영 신뢰성의 괴리를 드러냈다. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

## 점수 및 비용 구조 (2026-04-24 출시 기준)

DeepSeek V4는 V3 이후 첫 신규 아키텍처이며, MIT 라이선스와 2-tier 오픈웨이트 모델을 제공한다. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

*   **Claude Opus 4.7**: 점수 **91/100**. 이전 실행 데이터 기반. 재현 가능한 버그 1개만 확인. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **DeepSeek V4 Pro**: 점수 **77/100**. 비용 **$2.25** (프로모션 시 ~$0.55). Opus와 Kimi 사이 위치. Kimi 대비 9점 우위, 구조적 완성도 높음. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **Kimi K2.6**: 점수 **68/100**. 이전 실행 데이터 기반. 라이브 이벤트 스트리밍 누락 및 동일 실패 패밀리 발생. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **DeepSeek V4 Flash**: 점수 **60/100**. 비용 **$0.02**. 빌드 실패 및 엔트리 엔드포인트 라우팅 오류 발생. 다만 Tool-calling은 의외로 견고함. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

**비용 효율성**: Flash는 Kimi 대비 약 30배, Opus 대비 약 100배 저렴하며, Gemini 3.1 Flash Lite나 Haiku 4.5의 예산 티어보다도 저렴함. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

## 결함 Taxonomy (재현 기반 확인)

모든 모델이 '콘텐츠 충돌 하에서의 복구(recovery-under-contention)' 부분에서 첫 통과 시 가장 낮은 점수를 기록함. DeepSeek 모델의 구체적 결함은 다음과 같음. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

*   **만료된 Lease 완료 (Pro+Flash 공통)**: Heartbeat 시 Lease를 강제하지만, 완료 시점에는 적용되지 않음. 이로 인해 만료된 워커가 200 상태 코드로 스텝을 완료함. README는 이를 금지한다고 명시했으나 구현에는 반영되지 않음. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **크로스 런 스케줄링 기아 (Pro)**: Claim 로직이 후보 1개만 검사하는 구조. 해당 후보가 병렬 용량 제한이 있는 런 소속일 경우 빈 반환을 하고 다음 후보로 넘어가지 않음. 다른 런에 작업이 있어도 워커가 유휴 상태가 됨. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **빌드 무결성 (Pro)**: `npm test`는 통과하나 `npm run build`는 실패. `tsconfig`의 `noEmit` 설정과 `package.json`의 컴파일 산출물 실행 기대 간 충돌로, 클린 체크아웃 시 서버가 기동되지 않음. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **잘못된 라우트 접두사 (Flash)**: 엔트리 엔드포인트를 스펙(`/workflows/key/:key/runs`)이 아닌 `/runs/key/:key/runs`에 마운트하여 클라이언트 진입 불가(404). 테스트는 내부 함수 직접 호출로 통과하여 누락됨. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **실패한 런의 작업 할당 (Flash)**: 런 실패 후에도 동일 배치의 다른 스텝이 `blocked`가 아닌 `waiting_retry`로 승격됨. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **임의 JSON 거부 (Flash)**: 스펙은 array/string/number를 허용하나, 구현은 object만 통과시켜 array 입력 시 400 에러 발생. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

## 재사용 가능한 패턴 및 결정 근거

### 1. 방법론: "모델 자기 요약 신뢰 금지"
모델의 자기 요약(self-summary)을 신뢰하지 않고, **고립된 SQLite 타겟을 통한 재현(reproduction)**을 수행해야 함. 이는 기존 Fact-assertion verification 및 No Kind Default, BFCL harness-artifact-vs-model-fail 방법론과 동형이며, `model-bench-round2`의 채점 원칙으로 직결됨. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

### 2. Benchmaxxed vs Operational Reliability
표면적 구현(endpoint/schema/test/retry)은 수렴하지만, Lease 소유권, 복구, 병렬성 엣지 케이스는 여전히 취약함. 따라서 벤치 랙릭(rubric)은 **hard-correctness 경로에 높은 가중치**를 두어야 함. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

### 3. Quota 경제학 및 라우팅 근거
Max Plan(평정 요금제)의 토큰 가격은 소진 시점에 따라 극단적으로 변동함. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **소진 직전**: 토큰 가격 = 0 (여유 있음).
*   **소진 직후**: 토큰 가격 = 무한대 (사용 불가).
*   **결정 근거**: "화요일에 주간 할당량이 거의 소진된 상황"에서는 $0.02의 저렴한 모델이 품질 트레이드오프가 아니라 **유일하게 살아있는 옵션**이 됨. 이는 로컬 모델과 프론티어 모델 간 라우팅 결정의 핵심 근거가 됨. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

### 4. DeepSeek Fallback 데이터 및 Caveat
*   **성능**: V4 Pro는 "Opus 다음, Kimi보다 나음". ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **리스크**: 용량 이슈로 인해 Sonnet(5분) 대비 20-30분 정도 지연(slowness) 보고됨. 이는 실제 운영 환경에서의 Fallback 리스크 요인임. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   **적용성**: 공식 DeepSeek API를 Hermes Agent에 매일 사용하는 사례가 존재하며, 이는 본 시스템의 셋업과 동일함. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

## 신뢰도 및 출처
*   Kilo.ai 벤더 블로그이지만, **재현 기반**으로 엄격한 검증 수행 (studiomi300의 vote-farming 데모와 대조됨). ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   Opus/Kimi 숫자는 이전 실행 데이터를 재사용한 것이므로 재테스트되지 않았음(Caveat). ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]
*   r/kimi의 "Europe Claude vs China" 논쟁 댓글은 사실 오류(Claude는 US 기반)를 포함하므로 노이즈로 간주. ^[0525-1431_capture_deepseek-v4-kilo-flowgraph-bench.md]

출처: https://blog.kilo.ai/p/we-tested-deepseek-v4-pro-and-flash
