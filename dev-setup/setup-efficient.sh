#!/bin/bash

echo "🚀 맥북 개발환경 설치 (효율성 우선)"
echo "=================================="
echo "대상: 개인 개발자, 숙련자, 신규 프로젝트"
echo "특징: 10-100배 빠른 성능, 최신 도구"
echo ""

# 시스템 정보
echo "📱 시스템 정보:"
echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "아키텍처: $(uname -m)"
echo ""

# 사용자 확인
read -p "효율성 우선 설치를 진행하시겠습니까? (y/N): " -n 1 -r
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

# 현대적 CLI 도구들 설치
echo "현대적 CLI 도구 설치 중..."
brew install git tree bat exa fd ripgrep jq htop

# Git 설정
if [ ! -f ~/.gitconfig ]; then
    read -p "Git 사용자 이름을 입력하세요: " git_name
    read -p "Git 이메일을 입력하세요: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo "✅ Git 설정 완료"
fi

# ==============================================
# 2단계: Python 환경 (uv 고속)
# ==============================================
echo ""
echo "🐍 2단계: Python 환경 (uv - 초고속)"
echo "================================="

echo "uv 설치 중..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# PATH 설정
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Python 설치 및 설정
uv python install 3.12
uv python pin 3.12

echo "✅ uv + Python 설치 완료"

# ==============================================
# 3단계: Node.js 환경 (pnpm 효율)
# ==============================================
echo ""
echo "📦 3단계: Node.js 환경 (pnpm - 효율적)"
echo "===================================="

echo "Node.js 설치 중..."
brew install node

echo "pnpm 설치 중..."
npm install -g pnpm

# pnpm 호환성 설정
cat > ~/.npmrc << 'EOF'
node-linker=hoisted
shamefully-hoist=true
strict-peer-dependencies=false
auto-install-peers=true
EOF

# 전역 도구 설치
echo "개발 도구 설치 중..."
pnpm add -g typescript ts-node create-react-app @vue/cli vite

echo "✅ Node.js + pnpm 설치 완료"

# ==============================================
# 4단계: 추가 언어 (현대적 도구)
# ==============================================
echo ""
echo "🌐 4단계: 추가 언어 (현대적 도구)"
echo "============================="

read -p "Java를 설치하시겠습니까? (Y/n): " java_install
if [[ ! $java_install =~ ^[Nn]$ ]]; then
    brew install openjdk@17 gradle
    echo 'export JAVA_HOME=$(/usr/libexec/java_home -v17)' >> ~/.zshrc
    echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
    echo "✅ Java + Gradle 설치 완료"
fi

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

read -p "Ruby를 설정하시겠습니까? (Y/n): " ruby_install
if [[ ! $ruby_install =~ ^[Nn]$ ]]; then
    gem install bundler
    echo "✅ Ruby + Bundler 설정 완료"
fi

# ==============================================
# 5단계: 고성능 개발 도구
# ==============================================
echo ""
echo "⚡ 5단계: 고성능 개발 도구"
echo "======================="

read -p "VS Code를 설치하시겠습니까? (Y/n): " vscode_install
if [[ ! $vscode_install =~ ^[Nn]$ ]]; then
    brew install --cask visual-studio-code
    echo "✅ VS Code 설치 완료"
fi

read -p "Docker & 개발도구를 설치하시겠습니까? (Y/n): " docker_install
if [[ ! $docker_install =~ ^[Nn]$ ]]; then
    brew install --cask docker postman
    brew install httpie gh lazygit
    echo "✅ Docker + 개발도구 설치 완료"
fi

# ==============================================
# 6단계: 터미널 슈퍼차지
# ==============================================
echo ""
echo "🖥️  6단계: 터미널 슈퍼차지"
echo "========================"

read -p "Oh My Zsh + 고성능 플러그인을 설치하시겠습니까? (Y/n): " omz_install
if [[ ! $omz_install =~ ^[Nn]$ ]]; then
    # Oh My Zsh 설치
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # 고성능 플러그인들
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    
    # 플러그인 활성화
    sed -i '' 's/plugins=(git)/plugins=(git brew node npm python docker golang rust zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' ~/.zshrc
    
    # 유용한 별칭 추가
    cat >> ~/.zshrc << 'EOF'

# 효율적 별칭들
alias ll='exa -la'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='htop'
alias python='python3'
alias pip='pip3'

# Git 별칭
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# 개발 별칭
alias serve='python -m http.server 8000'
alias myip='curl ipinfo.io/ip'
EOF
    
    echo "✅ 터미널 슈퍼차지 완료"
fi

# ==============================================
# 7단계: 프로젝트 템플릿 함수
# ==============================================
echo ""
echo "📁 7단계: 프로젝트 템플릿 함수"
echo "=========================="

cat >> ~/.zshrc << 'EOF'

# 빠른 프로젝트 생성 함수들
new-python() {
    if [ -z "$1" ]; then echo "사용법: new-python <프로젝트명>"; return 1; fi
    uv init "$1" && cd "$1"
    echo "✅ Python 프로젝트 '$1' 생성 완료!"
}

new-react() {
    if [ -z "$1" ]; then echo "사용법: new-react <프로젝트명>"; return 1; fi
    pnpm create react-app "$1" && cd "$1"
    echo "✅ React 프로젝트 '$1' 생성 완료!"
}

new-next() {
    if [ -z "$1" ]; then echo "사용법: new-next <프로젝트명>"; return 1; fi
    pnpm create next-app "$1" && cd "$1"
    echo "✅ Next.js 프로젝트 '$1' 생성 완료!"
}

new-go() {
    if [ -z "$1" ]; then echo "사용법: new-go <프로젝트명>"; return 1; fi
    mkdir "$1" && cd "$1" && go mod init "$1"
    echo "✅ Go 프로젝트 '$1' 생성 완료!"
}
EOF

# ==============================================
# 설치 완료
# ==============================================
echo ""
echo "🎉 효율성 우선 설치 완료!"
echo "========================="

source ~/.zshrc

echo "📊 설치된 고성능 도구들:"
echo "- Homebrew + 현대적 CLI 도구들"
command -v uv >/dev/null && echo "- Python: uv (10-100배 빠름)"
command -v pnpm >/dev/null && echo "- Node.js: pnpm (70% 디스크 절약)"
command -v java >/dev/null && echo "- Java: OpenJDK + Gradle"
command -v go >/dev/null && echo "- Go: $(go version)"
command -v rustc >/dev/null && echo "- Rust: $(rustc --version)"

echo ""
echo "🚀 고성능 기능들:"
echo "- uv: Python 패키지 초고속 설치"
echo "- pnpm: Node.js 디스크 70% 절약"
echo "- bat, exa, fd, rg: 향상된 CLI 도구들"
echo "- 프로젝트 템플릿: new-python, new-react, new-next, new-go"

echo ""
echo "🎯 다음 단계:"
echo "1. 터미널 재시작: source ~/.zshrc"
echo "2. 프로젝트 생성: new-python my-project"
echo "3. 고성능 개발 시작!"

echo ""
echo "⚡ 효율적이고 빠른 개발환경이 준비되었습니다!"
