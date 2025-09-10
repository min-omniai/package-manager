#!/bin/bash

echo "⚖️  맥북 개발환경 설치 (균형 조합)"
echo "================================="
echo "대상: 대부분의 개발자 (추천)"
echo "특징: 성능 + 안정성 균형, 98% 호환성"
echo ""

# 시스템 정보
echo "📱 시스템 정보:"
echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "아키텍처: $(uname -m)"
echo ""

# 사용자 확인
read -p "균형 조합 설치를 진행하시겠습니까? (y/N): " -n 1 -r
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
    
    # PATH 설정
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

# 기본 + 유용한 CLI 도구들
echo "개발 도구 설치 중..."
brew install git tree jq bat exa fd

# Git 설정
if [ ! -f ~/.gitconfig ]; then
    read -p "Git 사용자 이름을 입력하세요: " git_name
    read -p "Git 이메일을 입력하세요: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo "✅ Git 설정 완료"
fi

# ==============================================
# 2단계: Python 환경 (프로젝트별 선택)
# ==============================================
echo ""
echo "🐍 2단계: Python 환경 (유연한 선택)"
echo "==============================="

echo "Python 패키지 매니저를 선택하세요:"
echo "1) uv (빠름, 최신) - 신규 프로젝트 권장"
echo "2) pip (안전, 표준) - 기존 프로젝트 권장"

read -p "선택 (1 또는 2): " python_choice

if [[ $python_choice == "1" ]]; then
    echo "uv 설치 중..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    uv python install 3.12
    echo "✅ uv + Python 설치 완료"
    PYTHON_MANAGER="uv"
else
    echo "Python + pip 설치 중..."
    brew install python@3.12
    python3 -m pip install --upgrade pip
    echo 'alias python=python3' >> ~/.zshrc
    echo 'alias pip=pip3' >> ~/.zshrc
    echo "✅ Python + pip 설치 완료"
    PYTHON_MANAGER="pip"
fi

# ==============================================
# 3단계: Node.js 환경 (pnpm + npm 병행)
# ==============================================
echo ""
echo "📦 3단계: Node.js 환경 (pnpm + npm)"
echo "================================"

echo "Node.js + pnpm 설치 중..."
brew install node
npm install -g pnpm

# pnpm 호환성 설정
cat > ~/.npmrc << 'EOF'
node-linker=hoisted
shamefully-hoist=true
strict-peer-dependencies=false
EOF

# 양쪽 도구로 기본 패키지 설치
echo "개발 도구 설치 중..."
pnpm add -g typescript create-react-app
npm install -g @vue/cli vite

echo "✅ Node.js + pnpm + npm 설치 완료"

# ==============================================
# 4단계: 언어별 맞춤 설치
# ==============================================
echo ""
echo "🌐 4단계: 추가 언어 설치"
echo "====================="

# Java
read -p "Java 개발을 하시나요? (y/N): " java_dev
if [[ $java_dev =~ ^[Yy]$ ]]; then
    echo "Java 빌드 도구 선택:"
    echo "1) Gradle (현대적, 빠름)"
    echo "2) Maven (안정적, 표준)"
    read -p "선택 (1 또는 2): " java_build
    
    brew install openjdk@17
    echo 'export JAVA_HOME=$(/usr/libexec/java_home -v17)' >> ~/.zshrc
    echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
    
    if [[ $java_build == "1" ]]; then
        brew install gradle
        echo "✅ Java + Gradle 설치 완료"
    else
        brew install maven
        echo "✅ Java + Maven 설치 완료"
    fi
fi

# Ruby
read -p "Ruby 개발을 하시나요? (y/N): " ruby_dev
if [[ $ruby_dev =~ ^[Yy]$ ]]; then
    gem install bundler
    echo "✅ Ruby + Bundler 설정 완료"
fi

# 기타 언어들
echo ""
echo "추가 언어 설치 (선택사항):"
read -p "Go를 설치하시겠습니까? (y/N): " go_install
if [[ $go_install =~ ^[Yy]$ ]]; then
    brew install go
    echo 'export GOPATH=$HOME/go' >> ~/.zshrc
    echo 'export PATH="$GOPATH/bin:$PATH"' >> ~/.zshrc
    mkdir -p ~/go/src ~/go/bin ~/go/pkg
    echo "✅ Go 설치 완료"
fi

read -p "Rust를 설치하시겠습니까? (y/N): " rust_install
if [[ $rust_install =~ ^[Yy]$ ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    echo "✅ Rust 설치 완료"
fi

# ==============================================
# 5단계: 개발 도구 설치
# ==============================================
echo ""
echo "💻 5단계: 개발 도구"
echo "=================="

# 필수 에디터
read -p "Visual Studio Code를 설치하시겠습니까? (Y/n): " vscode_install
if [[ ! $vscode_install =~ ^[Nn]$ ]]; then
    brew install --cask visual-studio-code
    echo "✅ VS Code 설치 완료"
fi

# 개발 도구들
echo ""
echo "추가 개발 도구 선택 (숫자로 구분, 예: 1 2 4):"
echo "1) Docker (컨테이너)"
echo "2) Postman (API 테스트)"
echo "3) SourceTree (Git GUI)"
echo "4) TablePlus (DB GUI)"

read -p "선택 (엔터로 건너뛰기): " tool_choices

for choice in $tool_choices; do
    case $choice in
        1)
            brew install --cask docker
            echo "✅ Docker 설치 완료"
            ;;
        2)
            brew install --cask postman
            brew install httpie
            echo "✅ Postman + HTTPie 설치 완료"
            ;;
        3)
            brew install --cask sourcetree
            echo "✅ SourceTree 설치 완료"
            ;;
        4)
            brew install --cask tableplus
            echo "✅ TablePlus 설치 완료"
            ;;
    esac
done

# ==============================================
# 6단계: 터미널 개선
# ==============================================
echo ""
echo "🖥️  6단계: 터미널 개선"
echo "===================="

read -p "Oh My Zsh를 설치하시겠습니까? (Y/n): " omz_install
if [[ ! $omz_install =~ ^[Nn]$ ]]; then
    # Oh My Zsh 설치
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # 유용한 플러그인들
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    
    # 플러그인 활성화 (설치된 언어에 따라)
    PLUGINS="git brew node npm python"
    [[ $java_dev =~ ^[Yy]$ ]] && PLUGINS="$PLUGINS gradle"
    [[ $go_install =~ ^[Yy]$ ]] && PLUGINS="$PLUGINS golang"
    [[ $rust_install =~ ^[Yy]$ ]] && PLUGINS="$PLUGINS rust"
    PLUGINS="$PLUGINS zsh-autosuggestions zsh-syntax-highlighting"
    
    sed -i '' "s/plugins=(git)/plugins=($PLUGINS)/" ~/.zshrc
    
    # 유용한 별칭 추가
    cat >> ~/.zshrc << 'EOF'

# 균형 잡힌 별칭들
alias ll='ls -la'
alias python='python3'
alias pip='pip3'

# Git 별칭
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# 개발 별칭
alias serve='python -m http.server 8000'
EOF

    # 설치된 도구에 따른 별칭
    if command -v bat >/dev/null; then
        echo "alias cat='bat'" >> ~/.zshrc
    fi
    if command -v exa >/dev/null; then
        echo "alias ls='exa'" >> ~/.zshrc
    fi
    
    echo "✅ Oh My Zsh + 플러그인 설치 완료"
fi

# ==============================================
# 7단계: 프로젝트 생성 도우미
# ==============================================
echo ""
echo "📁 7단계: 프로젝트 생성 도우미"
echo "=========================="

cat >> ~/.zshrc << EOF

# 프로젝트 생성 함수들 (설치된 도구에 따라)
EOF

if [[ $PYTHON_MANAGER == "uv" ]]; then
    cat >> ~/.zshrc << 'EOF'
new-python() {
    if [ -z "$1" ]; then echo "사용법: new-python <프로젝트명>"; return 1; fi
    uv init "$1" && cd "$1"
    echo "✅ Python 프로젝트 '$1' 생성 완료! (uv 사용)"
}
EOF
else
    cat >> ~/.zshrc << 'EOF'
new-python() {
    if [ -z "$1" ]; then echo "사용법: new-python <프로젝트명>"; return 1; fi
    mkdir "$1" && cd "$1"
    python -m venv .venv && source .venv/bin/activate
    echo "✅ Python 프로젝트 '$1' 생성 완료! (venv 사용)"
}
EOF
fi

cat >> ~/.zshrc << 'EOF'
new-react() {
    if [ -z "$1" ]; then echo "사용법: new-react <프로젝트명>"; return 1; fi
    if command -v pnpm >/dev/null; then
        pnpm create react-app "$1" && cd "$1"
    else
        npx create-react-app "$1" && cd "$1"
    fi
    echo "✅ React 프로젝트 '$1' 생성 완료!"
}

new-next() {
    if [ -z "$1" ]; then echo "사용법: new-next <프로젝트명>"; return 1; fi
    if command -v pnpm >/dev/null; then
        pnpm create next-app "$1" && cd "$1"
    else
        npx create-next-app "$1" && cd "$1"
    fi
    echo "✅ Next.js 프로젝트 '$1' 생성 완료!"
}
EOF

if [[ $go_install =~ ^[Yy]$ ]]; then
    cat >> ~/.zshrc << 'EOF'
new-go() {
    if [ -z "$1" ]; then echo "사용법: new-go <프로젝트명>"; return 1; fi
    mkdir "$1" && cd "$1" && go mod init "$1"
    echo "✅ Go 프로젝트 '$1' 생성 완료!"
}
EOF
fi

# ==============================================
# 설치 완료
# ==============================================
echo ""
echo "🎉 균형 조합 설치 완료!"
echo "======================"

source ~/.zshrc

echo "📊 설치된 도구들:"
echo "- Homebrew + 유용한 CLI 도구들"
echo "- Python: $PYTHON_MANAGER"
echo "- Node.js: pnpm + npm 병행"
command -v java >/dev/null && echo "- Java: OpenJDK + $(command -v gradle >/dev/null && echo 'Gradle' || echo 'Maven')"
command -v go >/dev/null && echo "- Go: $(go version | cut -d' ' -f3)"
command -v rustc >/dev/null && echo "- Rust: $(rustc --version | cut -d' ' -f2)"

echo ""
echo "⚖️  균형 잡힌 특징들:"
echo "- Python: 프로젝트에 따라 uv/pip 선택 가능"
echo "- Node.js: pnpm 효율성 + npm 호환성"
echo "- Java: 현대적 vs 안정적 도구 선택"
echo "- 프로젝트 생성: new-python, new-react, new-next"

echo ""
echo "🚀 다음 단계:"
echo "1. 터미널 재시작: source ~/.zshrc"
echo "2. 프로젝트 생성 테스트"
echo "3. 개발 시작!"

echo ""
echo "📚 사용 팁:"
echo "- Python 프로젝트: new-python my-project"
echo "- React 앱: new-react my-app"
echo "- 패키지 설치: brew install [패키지명]"
echo "- Git 상태: gs (git status 별칭)"

echo ""
echo "✅ 균형 잡힌 개발환경이 준비되었습니다!"
