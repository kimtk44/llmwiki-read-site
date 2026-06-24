---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/scope-creep-overthinking-kevinlynagh.md
graduated: 2026-06-02
model: qwen36-35b-a3b
slug: scope-creep-overthinking
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://kevinlynagh.com/newsletter/2026_04_overthinking/
---

# 과도한 고민이 시스템을 죽인다: Prototype-Driven의 교훈

## 요약
Emacs fuzzy 검색 도구 개발 중 'anchor 기능' 추가를 위해 한 달을 소모한 사례. 원래 목표(파일 검색)는 잊히고 anchor 정합성, tree-sitter 통합, 구조적 diff 비교 등으로 scope가 무한 확장됨. 결국 anchor 기능을 제거하고 원래 도구로 회귀하자 사용자 만족도가 오히려 상승함.
**핵심 주장**: **prototype-driven > research-driven**. PhD 수준의 선행 연구는 scope creep를 유발하므로, 논문 2-3편 읽기 후 바로 제작 시작이 낫다 ^[scope-creep-overthinking-kevinlynagh.md].

## 핵심 통찰
- **메타 결정 vs 구현 결정 혼동**: '무엇을 만들 것인가'와 '어떻게 만들 것인가'를 혼동하면 과설계가 시작됨.
- **연구 탐험의 함정**: 단순 프로젝트가 research expedition으로 변하면 결과는 원안보다 나빠짐.
- **완벽주의의 역설**: "더 좋게" 가려는 시도는 종종 "결국 안 만들어짐"으로 귀결됨.

## 재사용 가능한 패턴 및 결정 근거

### 1. Scope Creep 방지 메커니즘
- **마감기한의 힘**: 한정된 시간은 자연스러운 우선순위 강제 수단으로 작용하며, scope creep를 대부분 해결함.
- **조기 회귀(Minimum Viable Scope)**: 잘못된 방향(예: anchor 기능)을 일찍 prototype하여 버릴수록 회귀 비용이 작아짐. 매몰비용 압박을 피하려면 일찍 실패해야 함.

### 2. 도메인 이해도와 설계의 균형
- **도메인 지식의 양면성**: 도메인을 모르면 과설계, 잘 알면 과소설계 위험이 있음. 둘 다 함정이므로 균형 잡힌 판단이 필요함.
- **적정 영역**: "scope creep 회피"와 "필수 설계 누락" 사이의 적정 영역을 찾는 것이 시스템 설계의 핵심임.

### 3. 적용 패턴 (Plan 작성 시)
1. **Prototype 우선**: 검증 라운드 추가 전, 일단 1차 산출물 작성. 검증은 이후 진행.
2. **강제 마감 설정**: "사용량 6% 시점"과 같은 구체적인 마감을 통해 우선순위 자동 설정.
3. **Phase 1 Trial 의무화**: prototype 후 "이 방향이 잘못된 것은 아닌지" 1차 확인 의무화.
4. **도메인 이해도 명시**: prompt 시스템 설계 시 사용자 vault 운영 패턴 수준(어떤 wrapper/모델/산출물 기대)을 명시적으로 정의.

## 시사점 및 Contradiction Signal
- **정합 사례**: 본 vault의 `vault-discovery-layer-plan` 검증 라운드에서 LLM 리뷰들이 over-engineering 방향으로 끌었으나, 사용자의 "lean 시작 + 부활 키워드 자연 발견" 결정이 prototype-driven 회귀의 정확성을 입증함.
- **정반대 함정 (Memento `frag-2a6b35db`)**: 과설계 회피가 도를 넘어 **필수 설계 누락**으로 이어진 사례. wrapper가 prompt body를 직접 삽입하지 않고 간접 지시만 했을 때 산출물 품질이 저하됨. 이는 "scope creep 회피" ↔ "필수 핵심 누락" 두 함정의 적정 영역을 정의하는 중요한 참고 사항임.

## 더 파고 싶은 방향
1. **Prototype 후 회귀 메커니즘**: `vault-discovery-layer-plan`의 G1 승인 패턴이 회귀 메커니즘으로 작용했음. 다른 plan에도 동일 패턴 적용 시 효율 측정 필요.
2. **Trade-off 분석**: 마감기한 효과와 도메인 이해도(사용자 vault 운영 11개월+)의 결합이 prototype-driven 효율을 극대화할 가능성.
3. **Structural Diff 응용**: tree-sitter 기반 구조적 diff를 `doc-writing-agent-guide`의 HWP/HWPX 확장과 결합하여 한국어 문서 diff 도구로 적용 가능.

## Vault proximity
★★★★ — 본 세션 작업 패턴 및 plan 작성 일반 룰에 직접 적용 가능. 향후 plan 작성 및 LLM 리뷰 흡수 시 cross-ref 필수.

출처: https://kevinlynagh.com/newsletter/2026_04_overthinking/
