# 📌 맥북 개발환경 자동 설치

맥북을 처음 산 개발자를 위한 개발환경 자동 설치 스크립트입니다.

## 📍 빠른 시작

### 🤔 어떤 걸 선택해야 할까요?

| 상황 | 추천 스크립트 | 이유 |
|---|---|---|
| 회사 컴퓨터, 처음 사용 | 안전성 우선 | 100% 호환성, 안정적 |
| 개인 컴퓨터, 빠른 성능 원함 | 효율성 우선 | 10-100배 빠른 속도 |
| 잘 모르겠음 | 균형 조합 | 성능과 안정성 둘 다 |

<br>

### 1단계: 본인에게 맞는 설치 방식 선택!

#### 안전성 우선 - [setup-safe.sh](https://github.com/min-omniai/package-manager/blob/main/dev-setup/setup-safe.sh) (기업환경, 처음 사용자)
```bash
# 1. 스크립트 다운로드
curl -O https://raw.githubusercontent.com/min-omniai/package-manager/main/dev-setup/setup-safe.sh

# 2. 내용 확인 (선택사항 | 지워도 됩니다)
cat setup-balanced.sh

# 3. 실행 권한 부여
chmod +x setup-safe.sh

# 4. 실행
./setup-safe.sh
```

#### 효율성 우선 - [setup-efficient.sh](https://github.com/min-omniai/package-manager/blob/main/dev-setup/setup-efficient.sh) (개인 개발자, 빠른 성능 원하는 경우)
```bash
# 1. 스크립트 다운로드
curl -O https://raw.githubusercontent.com/min-omniai/package-manager/main/dev-setup/setup-efficient.sh

# 2. 내용 확인 (선택사항 | 지워도 됩니다)
cat setup-balanced.sh

# 3. 실행 권한 부여
chmod +x setup-efficient.sh

# 4. 실행
./setup-efficient.sh
```

#### 균형 조합 - [setup-balanced](https://github.com/min-omniai/package-manager/blob/main/dev-setup/setup-balanced.sh) (대부분의 개발자에게 추천)
```bash
# 1. 스크립트 다운로드
curl -O https://raw.githubusercontent.com/min-omniai/package-manager/main/dev-setup/setup-balanced.sh

# 2. 내용 확인 (선택사항 | 지워도 됩니다)
cat setup-balanced.sh

# 3. 실행 권한 부여
chmod +x setup-balanced.sh

# 4. 실행
./setup-balanced.sh
```

### 2단계: 터미널에 1단계 명령어 실행 시 나오는 문구
<img width="432" height="42" alt="image" src="https://github.com/user-attachments/assets/1fdc0f6f-32df-46a0-ac7a-5882bf12df01" />

<br>

<img width="335" height="63" alt="image" src="https://github.com/user-attachments/assets/b6885664-2d15-4e3b-9330-c4e8e71282c9" />

<br>

<img width="369" height="61" alt="image" src="https://github.com/user-attachments/assets/68b1fe0a-2d33-4f63-a166-1e247c7f37e8" />

<br>

<img width="307" height="61" alt="image" src="https://github.com/user-attachments/assets/565e5e31-0f46-449e-9e61-bd4f57e627f8" />

<br>

<img width="352" height="17" alt="image" src="https://github.com/user-attachments/assets/539939e5-7e97-4133-b0c4-8026a5ec8784" />

<br>

<img width="400" height="23" alt="image" src="https://github.com/user-attachments/assets/4c285e24-0a84-404f-8c63-ef8b4adc244d" />

<br>

<img width="392" height="22" alt="image" src="https://github.com/user-attachments/assets/61e83755-4671-48fe-97ab-94248dac5cb7" />

<br>

<img width="340" height="61" alt="image" src="https://github.com/user-attachments/assets/9450a9cc-6d3e-44fd-ad47-aee6a7fa5a53" />

<br>

<img width="488" height="19" alt="image" src="https://github.com/user-attachments/assets/b6b6748d-e051-479e-b894-ee528acf98c2" />

<br>

<img width="516" height="61" alt="image" src="https://github.com/user-attachments/assets/be45ab99-d43c-414a-9730-d41a4651edfc" />

**(y/N)** 중 자신에게 맞는 환경을 세팅하면 됩니다.

### 3단계: 설치 완료 후 확인
```bash
# 터미널 재시작 후 확인
brew --version
python3 --version
node --version
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
