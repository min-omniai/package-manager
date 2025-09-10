# 📌 맥북 개발환경 자동 설치

맥북을 처음 산 개발자를 위한 개발환경 자동 설치 스크립트입니다.

## 📍 빠른 시작

### 1단계: 본인에게 맞는 설치 방식 선택!

#### 1. 안전성 우선 (기업환경, 처음 사용자)
```bash
curl -fsSL https://github.com/min-omniai/package-manager/main/sh-file/setup-safe.sh | bash
```

#### 2. 효율성 우선 (개인 개발자, 빠른 성능 원하는 경우)
```bash
curl -fsSL https://github.com/min-omniai/package-manager/main/sh-file/setup-efficient.sh | bash
```

#### 3. 균형 조합 (대부분의 개발자에게 추천)
```bash
curl -fsSL https://github.com/min-omniai/package-manager/main/sh-file/setup-balanced.sh | bash
```

### 2단계: 설치 완료 후 확인
```bash
# 터미널 재시작 후 확인
brew --version
python3 --version
node --version
```

---

## 📍 어떤 걸 선택해야 할까요?

| 상황 | 추천 스크립트 | 이유 |
|---|---|---|
| 회사 컴퓨터, 처음 사용 | 안전성 우선 | 100% 호환성, 안정적 |
| 개인 컴퓨터, 빠른 성능 원함 | 효율성 우선 | 10-100배 빠른 속도 |
| 잘 모르겠음 | 균형 조합 | 성능과 안정성 둘 다 |

---

## 📍 안전한 설치 방법 (추천)

위의 한 줄 명령어가 불안하다면:

```bash
# 1. 스크립트 다운로드
curl -O https://github.com/min-omniai/package-manager/main/sh-file/setup-balanced.sh

# 2. 내용 확인 (선택사항)
cat setup-balanced.sh

# 3. 실행 권한 부여
chmod +x setup-balanced.sh

# 4. 실행
./setup-balanced.sh
```

---

## 📍 설치되는 것들

- **Homebrew**: 맥용 패키지 관리자
- **Python**: 프로그래밍 언어
- **Node.js**: 웹 개발용
- **Git**: 코드 관리
- **VS Code**: 코드 에디터
- **기타 개발 도구들**

---

## 📍 더 자세한 정보

패키지 매니저가 무엇인지, 왜 필요한지 알고 싶다면 [Guide.md](Guide.md)를 읽어보세요.

---

**시간**: 약 10-15분  
**용량**: 약 2-3GB  
**요구사항**: macOS 10.15 이상
