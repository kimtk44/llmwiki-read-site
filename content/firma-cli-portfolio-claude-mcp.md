---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/firma-cli-portfolio-claude-mcp.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: firma-cli-portfolio-claude-mcp
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://firma-cli.vercel.app/
---

# firma: Claude MCP 기반 로컬 퍼스트 자산관리 CLI

## 압축 지식 노트

**firma**는 해외 주식 투자자를 위한 **로컬 퍼스트 자산관리 CLI** 도구로, 구글 스프레드시트 대안으로 설계되었다 ^[firma-cli-portfolio-claude-mcp.md]. 핵심 기능은 **Finnhub API**를 통한 가격 자동 동기화, 거래 기록 관리, 월별 현금흐름 분석이며, **SQLite**를 로컬 데이터베이스로 활용한다 ^[firma-cli-portfolio-claude-mcp.md].

**핵심 차별점**은 **Claude Desktop MCP**와의 연동이다. 사용자는 Claude에게 "내 포트폴리오에서 금리 오르는 국면에 기술주 비중이 괜찮은가"와 같은 질의를 던지면, 도구가 직접 데이터를 조회하여 답변한다 ^[firma-cli-portfolio-claude-mcp.md]. 이는 AI 비서를 단순 텍스트 챗봇이 아닌 **사용자 도메인 데이터에 직접 연결된 분석 도구**로 재정의하는 패턴을 제시한다 ^[firma-cli-portfolio-claude-mcp.md].

**기술 스택 및 확장성**: TypeScript/Node.js 기반이며, Finnhub(가격)와 FRED(거시경제 지표) API를 통합한다 ^[firma-cli-portfolio-claude-mcp.md]. 댓글을 통해 FRED 거시 스냅샷, HHI 집중도 지수, 실시간 FX 등 후속 기능이 추가될 예정이며, macOS/Linux에서 즉시 실행 가능한 npm CLI로 배포된다 ^[firma-cli-portfolio-claude-mcp.md].

**재사용 가능한 패턴 및 결정 근거**:
1.  **도메인 특화 MCP 도구 등록**: firma와 같은 패턴은 [[mcp-config-editing-guide]] 및 [[_agent-server-quickstart]]에 stub으로 가치 있으며, [[claude-chat-to-code-transfer-analysis]]의 Claude chat ↔ CLI 연결 패턴과 결합 가능하다 ^[firma-cli-portfolio-claude-mcp.md].
2.  **한국 시장 적용 가능성**: 현재는 해외 주식 한정이나, Finnhub API는 키움/한투 OpenAPI와 1:1 대체 가능한 패턴으로 볼 수 있다 ^[firma-cli-portfolio-claude-mcp.md]. FRED 거시 분석은 한국은행 ECOS API로, HHI/FX 산식은 한국 시장에 적용 가능하다 ^[firma-cli-portfolio-claude-mcp.md].
3.  **인프라 통합**: firma의 로컬 SQLite는 [[memos-setup-plan]]의 Memos SQLite와 통합 가능하여, 사용자 운영 SQLite 인프라 단일화 후보가 된다 ^[firma-cli-portfolio-claude-mcp.md].

**한계 및 제약**:
*   **지원 시장**: 해외 주식만 지원하며 한국 주식 직접 지원은 X (fork 또는 자체 구현 필요) ^[firma-cli-portfolio-claude-mcp.md].
*   **API 제한**: Finnhub 무료 티어는 1년 데이터 및 분당 60회 호출 제한으로, 실전 투자 시 유료 플랜 필요 ^[firma-cli-portfolio-claude-mcp.md].
*   **환경 의존**: Claude Desktop UX를 가정하므로 Claude Code CLI에서는 직접 호출 불가 (MCP 프로토콜은 동일하나) ^[firma-cli-portfolio-claude-mcp.md].

**시점 의존성**: 이 자료는 2026년 4월 기준 정보이며, API 티어 제한이나 기능 추가 현황은 시점에 따라 변경될 수 있다 ^[firma-cli-portfolio-claude-mcp.md].

출처: https://firma-cli.vercel.app/
