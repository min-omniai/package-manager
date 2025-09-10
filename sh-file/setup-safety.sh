#!/bin/bash

echo "🛡️  맥북 개발환경 설치 (안전성 우선)"
echo "=================================="
echo "대상: 기업 환경, 초보자, 기존 프로젝트"
echo "특징: 100% 호환성, 안정성 최우선"
echo ""

# 시스템 정보
echo "📱 시스템 정보:"
echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "아키텍처: $(uname -m)"
echo ""

# 사용자 확인
read -p "안전성 우선 설치를 진행하시겠습니까? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ 설치가 취소되었습니다."
    exit 1
fi

# ==============================================
# 1단계: Homebrew 설치
# ==============================================
echo ""
echo "🍺 1단계: Homebrew 설치"
echo "====================="

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew 설치 중..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # PATH 설정 (M1/M2 vs Intel 자동 감지)
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
    fi
    
    source ~/.zshrc
    echo "✅ Homebrew 설치 완료"
else
    echo "✅ Homebrew 이미 설치됨: $(brew --version | head -1)"
fi

# ==============================================
# 2단계: 기본 개발 도구
# ==============================================
echo ""
echo "🛠️  2단계: 기본 개발 도구"
echo "======================="

echo "필수 도구 설치 중..."
brew install git curl wget tree jq

# Git 설정
if [ ! -f ~/.gitconfig ]; then
    read -p "Git 사용자 이름을 입력하세요: " git_name
    read -p "Git 이메일을 입력하세요: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo "✅ Git 설정 완료"
else
    echo "✅ Git 이미 설정됨"
fi

# ==============================================
# 3단계: Python 환경 (pip 안전)
# ==============================================
echo ""
echo "🐍 3단계: Python 환경 (pip)"
echo "========================="

echo "Python 3.12 설치 중..."
brew install python@3.12

# pip 업그레이드
python3 -m pip install --upgrade pip

# 별칭 설정
echo 'alias python=python3' >> ~/.zshrc
echo 'alias pip=pip3' >> ~/.zshrc

# 기본 패키지 설치
python3 -m pip install --user virtualenv

echo "✅ Python + pip 설치 완료"

# ==============================================
# 4단계: Node.js 환경 (npm 안전)
# ==============================================
echo ""
echo "📦 4단계: Node.js 환경 (npm)"
echo "=========================="

echo "Node.js 설치 중..."
brew install node

# npm 업데이트
npm install -g npm@latest

# 필수 도구 설치
npm install -g typescript create-react-app @vue/cli

echo "✅ Node.js + npm 설치 완료"

# ==============================================
# 5단계: 추가 언어 (선택)
# ==============================================
echo ""
echo "🌐 5단계: 추가 언어 설치"
echo "====================="

read -p "Java를 설치하시겠습니까? (Y/n): " java_install
if [[ ! $java_install =~ ^[Nn]$ ]]; then
    brew install openjdk@17 maven
    echo 'export JAVA_HOME=$(/usr/libexec/java_home -v17)' >> ~/.zshrc
    echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
    echo "✅ Java + Maven 설치 완료"
fi

read -p "Ruby를 설정하시겠습니까? (Y/n): " ruby_install
if [[ ! $ruby_install =~ ^[Nn]$ ]]; then
    gem install bundler
    echo "✅ Ruby + Bundler 설정 완료"
fi

# ==============================================
# 6단계: 개발 도구
# ==============================================
echo ""
echo "💻 6단계: 개발 도구"
echo "=================="

read -p "Visual Studio Code를 설치하시겠습니까? (Y/n): " vscode_install
if [[ ! $vscode_install =~ ^[Nn]$ ]]; then
    brew install --cask visual-studio-code
    echo "✅ VS Code 설치 완료"
fi

read -p "개발 도구들을 설치하시겠습니까? (Docker, Postman) (y/N): " tools_install
if [[ $tools_install =~ ^[Yy]$ ]]; then
    brew install --cask docker postman
    echo "✅ 개발 도구 설치 완료"
fi

# ==============================================
# 7단계: 터미널 개선
# ==============================================
echo ""
echo "🖥️  7단계: 터미널 개선"
echo "===================="

read -p "Oh My Zsh를 설치하시겠습니까? (Y/n): " omz_install
if [[ ! $omz_install =~ ^[Nn]$ ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # 플러그인 설치
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    # 플러그인 활성화
    sed -i '' 's/plugins=(git)/plugins=(git brew node npm python zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
    
    echo "✅ Oh My Zsh 설치 완료"
fi

# ==============================================
# 설치 완료
# ==============================================
echo ""
echo "🎉 안전성 우선 설치 완료!"
echo "========================="

source ~/.zshrc

echo "📊 설치된 도구들:"
echo "- Homebrew: $(brew --version | head -1)"
echo "- Git: $(git --version)"
echo "- Python: $(python3 --version) + pip"
echo "- Node.js: $(node --version) + npm"
command -v java >/dev/null && echo "- Java: $(java --version | head -1)"
command -v bundler >/dev/null && echo "- Ruby: $(ruby --version) + bundler"

echo ""
echo "🚀 다음 단계:"
echo "1. 터미널 재시작: source ~/.zshrc"
echo "2. 첫 프로젝트 생성"
echo "3. 개발 시작!"

echo ""
echo "📚 사용법:"
echo "- Python 가상환경: python -m venv myenv"
echo "- React 앱: npx create-react-app my-app"
echo "- 패키지 설치: brew install [패키지명]"

echo ""
echo "✅ 안전하고 안정적인 개발환경이 준비되었습니다!"
