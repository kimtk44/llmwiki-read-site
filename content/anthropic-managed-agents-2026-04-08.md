---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/anthropic-managed-agents-2026-04-08.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: anthropic-managed-agents-2026-04-08
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://claude.com/blog/claude-managed-agents
---

# Claude Managed Agents (Anthropic, 2026-04-08) 압축 지식 노트

## 1. 아키텍처 핵심: Brain/Hands/Session 분리 (Decoupling)
Anthropic의 Managed Agents는 클라우드 호스팅 에이전트 런타임으로, 기존 통합형 아키텍처를 해체하여 독립성과 확장성을 확보했다. 세 컴포넌트는 서로 독립적으로 실패하거나 교체 가능하다.

*   **Brain (추론 레이어)**: Claude 모델과 Harness로 구성. Harness는 Claude를 호출하고 Tool Call을 인프라로 라우팅하는 중재자 역할을 한다. "Harness는 모델 개선에 따라 낡는 가정들을 인코딩한다"는 점을 인정하고, 이를 추상화했다.
*   **Hands (실행 환경)**: 샌드박스 및 도구 집합. 단일 인터페이스 `execute(name, input) → string`을 제공하며, 컨테이너든 모바일 기기든 구현체에 구애받지 않는 스왑 가능(Swappable) 구조다.
*   **Session (상태 저장소)**: 영속적인 Append-only 이벤트 로그. 외부 컨텍스트 저장소로, `getEvents()`를 통해 위치 기반 슬라이스로 쿼리한다. 이는 "세션이 Claude의 컨텍스트 윈도우가 아님"을 의미하며, 컨테이너 실패 시 세션이 유실되던 기존 취약점을 해결한다.
*   **Stateless Harness**: Harness 인스턴스는 재생성 가능하며, `wake(sessionId)`로 세션을 복원하고 마지막 이벤트부터 재개(Resume)한다. Tool Call 발생 시 온디맨드 프로비저닝을 통해 TTFT(p50 60%, p95 90%+)를 대폭 개선했다. 이는 "Cattle not Pets" 철학으로, 핸드크래프트 서버 구축을 피하고 OS가 하드웨어를 가상화하듯 인터페이스는 Opinionated, 구현은 Unopinionated하게 설계되었다. ^[anthropic-managed-agents-2026-04-08.md]

## 2. 비용 구조 (Pricing & Billing)
2차원 과금 모델로, Token 사용량과 Session 실행 시간을 분리하여 청구한다.

*   **Token 차원**: 표준 Model Rate(Messages API 동일) 적용. 프롬프트 캐싱 멀티플라이어 동일 (5분 캐시 작성 1.25x, 1시간 2x, 읽기 0.1x). 세션 내 Web Search는 1,000회당 $10.
*   **Session Runtime 차원**: **$0.08/session-hour**. 밀리초 단위 Metered되며, `running` 상태일 때만 과금된다. `idle`(사용자 대기/Tool 승인 대기), `rescheduling`(일시적 재시도), `terminated` 상태는 과금 대상에서 제외된다. 최소 청구 창(Minimum billing window)은 명시되지 않았다.
*   **제외 사항**: Batch API 할인, Fast mode 프리미엄, Data residency 멀티플라이어, Long context 프리미엄, 3rd party 플랫폼(Bedrock/Vertex) 가격은 적용되지 않는다. Code Execution 컨테이너 요금($0.05/hr)은 Managed Agents 런타임이 대체하므로 별도 부과되지 않는다.
*   **비용 시뮬레이션**:
    *   **Opus 4.7 (1시간 Running, 50K Input/15K Output)**: Token $0.625 + Runtime $0.08 = **$0.705**. Aggressive 캐싱(40K 캐시 읽기) 시 **$0.525**.
    *   **Always-on 자동화 (Haiku 4.5, 24/7 Idle-heavy, Running 8h/day)**: Runtime $19.20 + Token 무시할 수준 → **월 $20-25**.
    *   **Sonnet 4.6 동급**: 월 **$25-30**.
    *   결론: 월 $30 미만으로 프로덕션 에이전트 운영이 가능하다. ^[anthropic-managed-agents-2026-04-08.md]

## 3. API 및 통합 패턴
*   **API Surface**: Beta 헤더(`anthropic-beta: managed-agents-2026-04-01`) 필수. SDK(Python, TS, Java, Go, C#, Ruby, PHP) 및 `ant` CLI 지원.
*   **핵심 리소스**: Agent(버전 관리), Environment(클라우드 컨테이너 템플릿), Session(상태 머신: idle → running → terminated), Events.
*   **라이프사이클**: Agent/Environment/Vault/Files/Memory는 Session과 독립적. Session 삭제 시 함께 삭제되지 않음.
*   **Rate Limits**: Create 300 req/min/org, Read 600 req/min/org. (Token 제한은 Messages API tier 동일).
*   **미명시 사항**: Max session duration, 동시 세션 제한, Agent당 최대 Tool 수는 공식 문서에 명시되지 않음. 단, Vault 문서상 Vault당 최대 20 Credential(= Agent당 최대 20 MCP Server)이 간접 상한으로 확인됨. ^[anthropic-managed-agents-2026-04-08.md]

## 4. 보안 및 MCP OAuth Vault 패턴
Credentials(자격 증명)가 샌드박스 내부로 유출되지 않도록 두 가지 패턴을 지원한다.

1.  **Resource Wire-in**: 샌드박스 초기화 시 토큰을 리소스 설정에 직접 박음 (예: Git remote 설정). 에이전트가 토큰을 직접 다루지 않음.
2.  **Vault Proxy**: OAuth 토큰을 Vault에 보관하고 전용 프록시로 라우팅. 프록시가 세션 연관 토큰을 처리하며, 샌드박스는 원본 자격 증명을 보지 않음.
*   **Built-in Toolset**: Bash, 파일 ops, Web search/fetch, MCP 서버 연결.
*   **파트너 채널**: Slack, Teams, Google Drive 등. ^[anthropic-managed-agents-2026-04-08.md]

## 5. 경쟁사 비교 및 우리 컨텍스트 적용 신호
*   **경쟁사**:
    *   **OpenAI/AWS Bedrock**: AWS Lock-in 경향. Anthropic은 Platform-agnostic(Claude API Direct).
    *   **OpenAI GPT-5.5**: Token-only billing. "Smarter engine" 포지셔닝. Anthropic은 "More reliable rails" (인프라).
    *   **Google Gemini Enterprise**: 풀 플랫폼(Studio, ADK, Sandbox 등). 거버넌스/위협탐지 빌트인. Anthropic은 Leaner API-first.
*   **적용 신호 (Watch List)**:
    *   **Memento ↔ Session Log 정합**: Anthropic의 Session Log(External Context)는 우리 Memento Fragment + Pending Pointer 디자인과 사상이 동일하다. 차이는 Memento가 Typed Semantic(fact/decision/error)을 쓰는 반면, Managed Agents는 Raw Interaction Event를 쓴다는 점.
    *   **MCP OAuth Vault 즉시 차용**: Telegram Bot Credential Isolation 및 Memento MCP Self-host Hardening에 적용 가능. 현재 환경변수/Prompt 경유 방식의 표준화 신호.
    *   **CC Remote Routines 대체**: Pending Phase 6-7의 Bespoke 작업은 Managed Agents PoC로 대체 가능. TUI 블로킹 문제를 비동기 세션 모델로 구조적 해결.
    *   **아키텍처 보강**: `claude-harness-architecture`의 §3(Provider Routing), §3.4(Hooks), §7(Context Discipline), §8(Chajooin Operational Case)가 Anthropic의 Decoupling 및 Stateless 설계로 검증됨. ^[anthropic-managed-agents-2026-04-08.md]

## 6. 재사용 가능한 패턴 및 결정 근거
*   **패턴 1: Stateless Session Resume**: `wake(sessionId)` → `getSession(id)` → Last Event Resume. 컨테이너 실패 시 상태 유실 방지 및 빠른 복원.
*   **패턴 2: External Event Log as Truth**: 컨텍스트 윈도우에 모든 것을 욱여넣지 않고, Append-only Event Log를 외부 저장소로 관리하여 컨텍스트 효율성 및 내구성 확보.
*   **패턴 3: Credential Isolation via Proxy**: 에이전트 실행 환경(Sandbox)에 직접 자격 증명을 전달하지 않고, Vault-Proxy 경유로 라우팅하여 보안성 강화.
*   **결정 근거 (PoC)**: 월 $20-30 수준의 낮은 TCO로, 기존 Bespoke 자동화(개발/운영 부담) 대비 Managed Agents PoC 도입이 타당함. 특히 1개 Lazyagent Task를 Managed Agents 세션으로 포트하여 Running Time vs Wall Time를 측정하는 것이 우선 과제. ^[anthropic-managed-agents-2026-04-08.md]

## 7. 시점 의존성 및 제한사항
*   **시점**: 2026-04-08 Public Beta 기준. 2026-04-29 기준 추가 Docs Fetch로 일부 미명시 사항(Max Session Duration 등)이 여전히 미발표 상태임을 확인.
*   **Multi-Agent**: Research Preview 단계로, 별도 액세스 폼 신청 필요. 1단계 위임만 지원(재위임 불가).
*   **환경**: 지원 패키지 매니저는 apt, cargo, gem, go, npm, pip 등. 네트워킹은 Unrestricted(기본) 또는 Limited. ^[anthropic-managed-agents-2026-04-08.md]

출처: https://claude.com/blog/claude-managed-agents
