---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/tui-builders.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: tui-builders
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://tui.builders
---

# tui.builders — 시각적 TUI 설계 및 Rust 코드 생성 도구

## 압축 지식 노트

**핵심 기능 및 기술 스펙**
*   **역할**: 브라우저 기반 시각적 드래그 앤 드롭 설계 도구로, TUI(Terminal UI) 레이아웃을 Rust 코드로 자동 생성 ^[tui-builders.md].
*   **라이브러리**: `SuperLightTUI` (약칭 `slt`) 사용. CSS flexbox 및 Tailwind 스타일링 패러다임 적용 ^[tui-builders.md].
*   **성능 및 안정성**: 의존성 2개, `unsafe` 코드 0, 프레임 처리 시간 약 1ms ^[ui-builders.md].
*   **코드 패턴**: 체이닝 메서드를 통한 선언적 UI 구성 (예: `ui.bordered().p().gap().col()`) ^[tui-builders.md].

**재사용 가능한 패턴 및 결정 근거**
*   **프로토타이핑 도구**: Rust 기반 서버 CLI/TUI 도구 개발 시, 빠른 프로토타입 제작을 위한 시각적 설계 도구로 활용 가능 ^[tui-builders.md].
*   **개발 배경**: 한국 개발자(subinium) 제작 ^[tui-builders.md].

**메타데이터**
*   **분류**: `remember` (즉시 학습 대상은 아니나, 향후 도구 필요 시 참조용) ^[tui-builders.md].
*   **시점**: 2026-03-18 기준 정보 ^[tui-builders.md].

출처: https://tui.builders
