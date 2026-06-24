---
type: reading-digest
source: /home/taekyu/workspace/pkm/obsidian-vault/03 Reference/Articles/tts-landscape-2026.md
graduated: 2026-06-10
model: qwen36-35b-a3b
slug: tts-landscape-2026
fidelity: faithful-korean (no-elaborate, cited, original preserved in vault)
source_url: https://huggingface.co/Supertone/supertonic-3
---

# Local Voice/Audio Models Landscape — 2026-03 압축 노트

## 핵심 인사이트
2026년 TTS 생태계의 경쟁 축은 모델 성능보다 **"컨트롤 방식"** (클로닝, 감정, 텍스트 기반 스타일, 시간 제어)으로 이동함 ^[tts-landscape-2026.md].

## TTS 모델 분류 및 재사용 포인트

### 1. Baseline / Ultra-light (실시간·경량)
*   **Kokoro (~82M, CPU)**: Apache 2.0. TTS Arena 1위, 산업 표준 baseline. 다국어 지원(한국어 포함, 억양은 영어식). 클로닝 불가, 감정 제어 제한적. CPU 실시간 구동 가능 ^[tts-landscape-2026.md].
*   **Supertonic 3 (~99M, CPU/ONNX)**: MIT/OpenRAIL-M. 한국어/일본어 포함 31개 언어. **재사용 포인트**: `<laugh>`, `<breath>` 등 **인라인 감정 태그** 지원 (Tier 1 드문 기능). Voice Builder로 제로샷 커스텀 가능. GPU 불필요, Raspberry Pi 등 임베디드 실시간 합성 적합. 전처리 없이 `$5.2M`, `30kph` 등 자연 텍스트 발음 ^[tts-landscape-2026.md].
*   **PocketTTS (~200M)**: CPU 2~8GB, 클로닝 가능 ^[tts-landscape-2026.md].

### 2. Balanced / Cloning-capable (범용 고품질)
*   **Qwen3-TTS (1.7B)**: Apache 2.0. ~8GB VRAM. 제로샷 클로닝 및 텍스트 기반 음성 디자인 가능. `faster-qwen3-tts` + CUDA graphs로 ~4x RTF 달성. 한국어 공식 지원 불명확 ^[tts-landscape-2026.md].
*   **EchoTTS (2.4B)**: 8GB+ RAM, 클로닝 가능, 커뮤니티 평가 높음 ^[tts-landscape-2026.md].

### 3. Expressive / Emotion-first (감정·표현력 특화)
*   **IndexTTS2**: 감정과 화자 분리. 4가지 감정 입력 방식(참조 오디오, 텍스트, 벡터 슬라이더, 자동 추론). **재사용 포인트**: ms 단위 정밀 **duration control** (더빙/립싱크용). 중국어 최적화, 한국어는 G2P 변환 필요 가능 ^[tts-landscape-2026.md].
*   **ChatTTS**: 구어체(추임새, 웃음) 제어 최고 수준. `[oral]`, `[laugh]`, `[break]` 태그 사용. 한국어 공식 미지원 (중/영만), CC BY-NC 4.0 ^[tts-landscape-2026.md].
*   **F5-TTS / E2-TTS**: Diffusion 기반 제로샷 클로닝 품질 우수 ^[tts-landscape-2026.md].

### 4. Production / Full-stack
*   **MOSS-TTS Family**: 5개 모델군 (TTS 8B, Local 1.7B 등). 20개 언어(한국어 포함). GGUF 양자화로 8GB GPU 구동 가능. Zero-shot 클로닝, 1시간 연속 생성, 음소/핀인 레벨 제어. **재사용 포인트**: OpenClaw Skills 존재, 파이프라인 통합 용이 ^[tts-landscape-2026.md].

### 5. Custom / Training
*   **VoxCPM**: Common Voice 20시간으로 새 언어 학습 가능. 한국어 커스텀 TTS의 현실적 경로 (데이터 준비 고됨) ^[tts-landscape-2026.md].
*   **GPT-SoVITS**: 1분 데이터로 클로닝 가능한 로컬 유저 다수 사용 모델 ^[tts-landscape-2026.md].

## ASR (Speech-to-Text)

### Cohere Transcribe (2B, Apache 2.0) — ASR SOTA
*   **성능**: WER 5.42% (Open ASR Leaderboard 1위). 한국어 공식 지원. 처리속도 525분/분 (RTF 동급 대비 3x).
*   **아키텍처**: Fast-Conformer encoder-decoder. vLLM 네이티브 지원.
*   **제한사항**: 자동 언어감지, 타임스탬프, 화자분리 미지원 (기본 모델). VAD/noise gate 전처리 필수 ^[tts-landscape-2026.md].
*   **재사용 포인트**: LLM 백본 ASR 대비 추론 속도 압도적, 서빙 비용 효율적 ^[tts-landscape-2026.md].

#### Update 2026-05-25: 화자분리·타임스탬프 fine-tune
*   **모델**: `syvai/cohere-transcribe-diarize` (Apache 2.0).
*   **기능**: 8 화자 토큰 + 300 타임스탬프 토큰(100ms 해상도) full fine-tune. 단일 디코더 패스로 `<|spltoken|><|t:time|> text` 출력.
*   **성능**: 30초 이내 청크 기준 K≤4 화자 양호. 5~8 화자 시 성능 열화.
*   **주의**: 화자분리 학습 데이터는 **영어 전용**. 나머지 언어 화자분리/타임스탬프 미검증. 전사 품질은 base 모델 대비 약간 저하 ^[tts-landscape-2026.md].

### 기타 ASR 모델 비교
*   **Whisper Large v3**: WER 7.44%, 생태계最广, 한국어 지원.
*   **ElevenLabs Scribe v2**: WER 5.83%, 상용.
*   **Qwen3-ASR**: WER 5.76%, LLM 백본 기반, 추론 느림 ^[tts-landscape-2026.md].

## 서버 적용 전략 (24GB VRAM, RX 7900 XTX)
*   **Layer 1 (상주)**: Kokoro (~0.5GB) — 실시간 알림/기본 읽기.
*   **Layer 2 (로딩)**: MOSS-TTS 8B 또는 Qwen3-TTS (~8GB) — 고품질 생성/클로닝.
*   **ASR**: Cohere Transcribe Docker — Kokoro와 VRAM 공존 가능.
*   **차별화**: IndexTTS2 감정 제어 → n8n 워크플로우 연동 ^[tts-landscape-2026.md].

## AMD (ROCm) 호환성 주의
*   대부분 TTS/ASR 모델 NVIDIA CUDA 최적화.
*   Triton 커널 사용 모델은 ROCm 포팅 필요. Docker 권장.
*   Kokoro, MOSS(llama.cpp 경로)는 상대적으로 안전. `faster-whisper`는 ROCm 비공식 지원, 수동 빌드 또는 CPU fallback 필요 ^[tts-landscape-2026.md].

## 커뮤니티 패턴: Whisper STT + 에이전트 결합
*   **패턴**: 로컬 Whisper(STT) → GPT 엔트리 결합 → 텔레봇 음성 메시지 → 자동 라우팅.
*   **적용 후보**: `faster-whisper` ROCm 빌드 + 텔레봇 `/voice` 커맨드 → STT 변환 → `vault-agent.sh` 라우팅. Phase 3-4 텔레봇 파이프라인에 음성 레이어 추가 가능 ^[tts-landscape-2026.md].

## 참고: 영상 자막 도구 (WhisperSubTranslate)
*   **아키텍처 재사용 포인트**: **"STT 로컬 고정 + 번역 엔진 플러그형"** 패턴. 완전 오프라인(local HY-MT GGUF) ↔ 온라인 키(MyMemory/DeepL/OpenAI/Gemini) 스위처블.
*   **주의**: whisper.cpp auto-download는 CUDA 바이너리 → AMD는 수동 빌드 필요. 한국어 오프라인 MT 품질 미검증 ^[tts-landscape-2026.md].

출처: https://huggingface.co/Supertone/supertonic-3
