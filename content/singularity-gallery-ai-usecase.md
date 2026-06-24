---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/singularity-gallery-ai-usecase.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: singularity-gallery-ai-usecase
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
---

# 40대 비전공자 AI 실전 자동화 사례 (OpenClaw 기반)

## 1. 프로필 및 학습 배경
- **인물**: 40대 중견회사 운영지원팀(오케스트레이터 역할), 코딩 비전공, 국비 AI 강의 3개 수료 및 독학 ^[singularity-gallery-ai-usecase.md].
- **환경**: Windows(사무실) + Mac(자택) 듀얼 환경, GPT Pro + Claude Max + API 법인카드 지원 ^[singularity-gallery-ai-usecase.md].
- **학습 경로**: 바이브코딩 시도 후 포기 → 맥/터미널 기초 → Notion DB/마크다운 → n8n/Make 학습 → OpenClaw 세팅 (3개월 점진적 스킬업) ^[singularity-gallery-ai-usecase.md].

## 2. 업무 자동화 패턴
- **ERP 크롤링 및 보고서 생성**: OpenClaw 내부 브라우저와 Bitwarden CLI를 활용한 자동 로그인으로 사내 웹 ERP 접근, 데이터 수집 후 보고서 자동 생성. 사내망 특성상 보안 리스크 낮아 권한 개방 ^[singularity-gallery-ai-usecase.md].
- **텔레그램 봇 문서 생성**: 텔레그램에서 명령어 입력 시 Claude Code가 파이썬을 실행하여 문서 생성 후 파일 전송. 기존 1~2시간 소요 작업을 수초 내 처리 ^[singularity-gallery-ai-usecase.md].
- **멀티디바이스 가이드라인 생성**: GPTs와 Claude를 활용해 업무 설명을 입력하고, 사무실(Win)과 자택(Mac)별 작업 가이드라인 마크다운 파일 자동 생성. 최종적으로 OpenClaw와 연계해 크론 자동화 여부 확인 ^[singularity-gallery-ai-usecase.md].
- **이상 거래 탐지 및 재조정**: 원자재 가격 인상 시 비정상 대량 주문 감지. 특정 상품 필터링 후 거래처별 평상시 주문량(선형 회귀분석 활용)을 산출하여 주문량 재조정 ^[singularity-gallery-ai-usecase.md].

## 3. 개인 자동화 및 인프라
- **iMessage AI 응답 시스템**:
    - **아들**: allow-list 등록 후 "자상한 아빠" 페르소나로 AI 자동 응답. 숙제 사진 해설 및 일상 질문 답변 ^[singularity-gallery-ai-usecase.md].
    - **아내**: Apple Calendar 및 Reminder와 연계. "퇴근하고 올 때 두부 사와" 등 음성/텍스트 명령을 리마인더로 자동 저장 ^[singularity-gallery-ai-usecase.md].
    - **구조**: 업무 번호는 AI 응답, 개인 번호는 직접 응답하는 이중 구조 운영 ^[singularity-gallery-ai-usecase.md].
- **iPhone 노드화 구상**: iPhone을 Mac(OpenClaw)의 휴대용 인터페이스 및 보조 실행 단말로 활용. Tailscale을 통해 iPhone에서 Mac으로 원격 터미널 접속 가능 ^[singularity-gallery-ai-usecase.md].
- **인프라 구성**:
    - **에이전트**: OpenClaw (Mac, 3개월 점진적 세팅) ^[singularity-gallery-ai-usecase.md].
    - **CLI**: Claude Code + GPT Codex ^[singularity-gallery-ai-usecase.md].
    - **원격**: Tailscale (iPhone ↔ Mac 터미널) ^[singularity-gallery-ai-usecase.md].
    - **보안**: Bitwarden CLI 자동 로그인, 빌트인 스킬만 사용 ^[singularity-gallery-ai-usecase.md].
    - **메시징**: 텔레그램 봇(업무), iMessage(개인) ^[singularity-gallery-ai-usecase.md].
    - **자동화**: 크론 기반, n8n/Make 학습 중 ^[singularity-gallery-ai-usecase.md].

## 4. 재사용 가능한 패턴 및 결정 근거
- **ERP 크롤링 패턴**: OpenClaw 내부 브라우저 + 비밀번호 관리자 CLI 조합은 청구빌딩 등 업무에 적용 가능 ^[singularity-gallery-ai-usecase.md].
- **텔레그램 봇 파이프라인**: 텔레그램 봇 → Claude Code 파이썬 실행 → 파일 전송 패턴은 GeekNews #28079 사례와 유사 ^[singularity-gallery-ai-usecase.md].
- **iMessage 자동 응답**: Personal-Agent-MOC의 실제 구현 사례로 활용 가능 ^[singularity-gallery-ai-usecase.md].
- **전략적 노출**: 자동화 역량을 조직에 과시하지 않고 "적당히 뜸 들이기"하는 실무적 지혜 ^[singularity-gallery-ai-usecase.md].
- **워크플로우 분리**: 사무실과 자택 간 멀티디바이스 가이드라인 마크다운 자동 생성을 통한 워크플로우 분리 아이디어 ^[singularity-gallery-ai-usecase.md].
