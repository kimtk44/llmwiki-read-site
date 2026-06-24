---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/scope-creep-overthinking-kevinlynagh.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: scope-creep-overthinking-kevinlynagh
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://kevinlynagh.com/newsletter/2026_04_overthinking/
---

# 과도한 고민이 시스템을 죽인다: Prototype-Driven의 교훈

## 압축 지식 노트

**핵심 주장**: 연구 주도(Research-driven) 개발은 Scope Creep를 유발하여 프로젝트를 실패로 이끈다. **Prototype-driven(시제품 우선)** 접근이 더 나은 결과와 빠른 회귀를 가능하게 한다. 저자는 Emacs fuzzy 검색 도구 개발 중 'anchor 기능' 추가를 위해 한 달을 낭비하며, 단순한 파일 검색이 tree-sitter 통합, 구조적 diff 비교 등 무한한 확장(Scope Creep)에 빠지는 경험을 했다. 결국 anchor 기능을 제거하고 원래 도구로 회귀했을 때 사용자 만족도가 높아졌다. 이는 "더 좋게" 가는 길이 종종 "결국 안 만들어짐"으로 귀결됨을 시사한다 ^[scope-creep-overthinking-kevinlynagh.md].

**주요 인사이트**:
*   **메타 결정 vs 구현 결정 혼동**: '무엇을 만들지'와 '어떻게 만들지'를 혼동하면 과설계가 시작된다. 단순 프로젝트가 연구 탐사 expedition으로 변하면 결과는 원안보다 나빠진다 ^[scope-creep-overthinking-kevinlynagh.md].
*   **마감기한의 효과**: 명확한 마감기한은 Scope Creep를 자연스럽게 해소하며 우선순위를 강제한다 ^[scope-creep-overthinking-kevinlynagh.md].
*   **도메인 이해도의 함정**: 도메인 지식이 부족하면 과설계, 지나치면 과소설계 위험이 있다. 균형 잡힌 이해도가 필요하다 ^[scope-creep-overthinking-kevinlynagh.md].
*   **회귀 비용 최소화**: 잘못된 방향(예: anchor 기능)으로 빠졌을 때 매몰비용 압박이 발생한다. 일찍 Prototype를 하고 회귀할수록 비용이 작다 ^[scope-creep-overthinking-kevinlynagh.md].

**재사용 가능한 패턴 및 결정 근거**:
1.  **Prototype 우선 원칙**: 검증 라운드나 추가 연구 전, 일단 작성/구현을 완료한다. 검증은 1차 산출물 이후에 수행한다 ^[scope-creep-overthinking-kevinlynagh.md].
2.  **강제 마감 설정**: "사용량 6% 시점"과 같은 구체적인 시점을 마감으로 설정하여 자연스러운 우선순위 설정을 유도한다 ^[scope-creep-overthinking-kevinlynagh.md].
3.  **조기 회귀 점검**: Prototype 후 "이 방향이 잘못된 것은 아닌지" 1차 확인을 의무화하여 Phase 1 Trial을 실시한다 ^[scope-creep-overthinking-kevinlynagh.md].
4.  **도메인 이해도 명시**: Prompt 시스템 설계 시 사용자 Vault 운영 패턴 수준(어떤 Wrapper/모델/산출물 기대)을 명시하여 도메인 이해도 균형을 맞춘다 ^[scope-creep-overthinking-kevinlynagh.md].

**반대 함정 주의 (Contradiction Signal)**:
Scope Creep 회피가 도를 넘어 **필수 설계 누락**으로 이어질 수 있다. 예컨대 Wrapper가 prompt body를 직접 삽입하지 않고 간접 지시만 했을 때, 필수 항목(★1-5, dig-further)이 누락된 사례가 있다. "Scope Creep 회피"와 "필수 핵심 누락" 사이의 적정 영역을 찾는 것이 시스템 설계의 핵심이다 ^[scope-creep-overthinking-kevinlynagh.md].

**추가 탐구 방향**:
*   Prototype 후 회귀 메커니즘의 효율 측정
*   마감기한과 도메인 이해도의 Trade-off 분석
*   Tree-sitter 기반 Structural Diff를 한국어 문서(HWP/HWPX)에 적용하는 가능성 ^[scope-creep-overthinking-kevinlynagh.md].

출처: https://kevinlynagh.com/newsletter/2026_04_overthinking/
