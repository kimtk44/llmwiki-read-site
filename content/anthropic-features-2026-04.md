---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/anthropic-features-2026-04.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: anthropic-features-2026-04
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
---

# Anthropic Claude 4월 업데이트 (2026-04-27)

## 1. Claude Design: 디자인 협업 및 핸드오프
안트로픽은 Opus 4.7 기반의 **Claude Design**을 공개했다. 이는 디자인, 프로토타입, 슬라이드, 원페이저 생성을 위한 협업 도구로, 인라인 코멘트, 텍스트 직접 편집, 그리고 간격·색·레이아웃을 실시간으로 조정할 수 있는 **adjustment knobs**를 제공한다. 팀 실시간 협업이 지원되며, 생성된 결과는 URL, 폴더, Canva, PDF, PPTX, standalone HTML로 내보낼 수 있다. 특히 **Claude Code로 직접 핸드오프**가 가능하며, 코드베이스와 디자인 파일을 자동 읽어서 브랜드 색, 타이포그래피, 컴포넌트 일관성을 적용하는 **디자인 시스템** 기능을 갖춘다. Pro/Max/Team/Enterprise 구독으로 접근 가능하나, Enterprise는 관리자 활성화가 필요하며 현재는 research preview 단계다. 기존 청구빌딩 프로젝트에서 docx-js 직생성 대신 디자인 도구 활용 검토가 유력하다. ^[anthropic-features-2026-04.md]

## 2. Claude Opus 4.7: 성능 및 품질 향상
Opus 4.7은 어려운 코딩 작업의 일관성을 높이고, **vision 해상도를 개선**했으며, 인터페이스/슬라이드/문서 생성의 미적 감각("tasteful")을 향상시켰다. 우리 환경에서는 이미 `claude-opus-4-7` (1M context)이 사용 중이며, 관련 노트가 다수 존재한다. ^[anthropic-features-2026-04.md]

## 3. Claude Managed Agents: 완전 관리형 에이전트
완전 관리형 agent harness로, Claude를 자율 에이전트로 실행한다. 보안 샌드박스, 빌트인 도구, SSE 스트리밍, 컨테이너 설정을 제공한다. 현재 진행 중인 CC Remote Routines 이관 트랙([[telegram-bot-role-reassessment]])의 대안으로 검토 가치가 있다. ^[anthropic-features-2026-04.md]

## 4. Claude Code CLI (Week 14, v2.1.86 → v2.1.91)
*   **Computer use in CLI** (research preview): 터미널에서 Claude가 네이티브 앱을 클릭하고 스크린샷을 찍으며 자체 검증한다. iOS 시뮬레이터/macOS GUI 앱에 verification loop를 지원하며, `/mcp` 명령어로 `computer-use` 토글이 가능하다. 이는 Phase 6-7 자동화([[claude-harness-architecture]])와 연결된다.
*   **`/powerup`** (v2.1.90): 신기능에 대한 인터랙티브 레슨을 제공한다. 매주 신기능을 따라잡는 부담을 해소할 수 있는 후보이다.
*   **Flicker-free renderer** (v2.1.89): alt-screen과 virtualized scrollback을 적용하여 화면 깜빡임을 제거한다. 우리 환경은 이미 `CLAUDE_CODE_NO_FLICKER=1`을 적용 중이며, unset 시 옛 모드로 롤백 가능하다.
*   **MCP result-size override** (v2.1.91): `anthropic/maxResultSizeChars`를 통해 툴별 결과 크기 한도(~500K)를 설정할 수 있다. DB 스키마나 파일트리 같은 큰 페이로드에 유용하며, 캐시 TTL 운영 룰([[tool-operational-notes]])과 같은 맥락이다.
*   **Plugin bin/ executables on PATH** (v2.1.91): 플러그인 루트의 `bin/` 디렉토리가 Bash PATH에 자동 추가되어 CLI helper 묶음 배포가 편리해졌다.
*   **기타 부수 기능**: PermissionDenied hook + retry, PreToolUse `defer` value, `disableSkillShellExecution`, Edit 명령어에서 Read 생략 후 cat/sed로 본 파일 직접 동작, 50K+ hook output 디스크 저장, thinking summaries 기본 off, Voice mode의 push-to-talk/Windows WebSocket/macOS Apple Silicon mic 지원, `claude-cli://` 멀티라인 deep link 등이 추가되었다. ^[anthropic-features-2026-04.md]

## 재사용 패턴 및 결정 근거
*   **디자인 도구 도입 검토**: 청구빌딩 문서 갱신 시 docx-js 직생성보다 Claude Design의 자동화된 디자인 시스템 및 Claude Code 핸드오프 기능이 효율적일 수 있다.
*   **CLI 자동화 강화**: 터미널 기반 Computer use는 GUI 앱 제어 및 검증 루프를 통해 자동화 정확도를 높일 수 있는 잠재력이 있다.
*   **운영 부담 경감**: `/powerup`을 통해 신기능 학습 부담을 줄이고, Flicker-free 렌더러는 이미 적용되어 안정성을 확보했다.
*   **대안 탐색**: Managed Agents는 기존 Telegram 봇 역할 재평가([[telegram-bot-role-reassessment]]) 트랙의 대안으로 고려해 볼 수 있다. ^[anthropic-features-2026-04.md]
