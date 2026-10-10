# My Dotfiles

macOS 终端配置，用 GNU Stow 管理。参考了 [kmeykranz/dotfiles](https://github.com/kmeykranz/dotfiles) 的工作流。

## 工具链

- **Ghostty** — 终端模拟器
- **zsh** + fzf + zsh-autosuggestions + zsh-syntax-highlighting + zoxide
- **tmux** — 终端复用（`|` / `-` 分屏，鼠标支持，escape-time 0）
- **Yazi** — 文件管理（`y` 命令，退出后 shell 同步 cwd）
- **LazyGit** — `lg` 命令
- Homebrew 统一安装；本仓库 `stow <包名>` 铺设配置

## 结构

```
dotfiles/
├── zsh/    → ~/.zshrc
└── tmux/   → ~/.tmux.conf
```

## 新机恢复

```bash
brew install stow fzf zoxide yazi lazygit tmux \
  zsh-autosuggestions zsh-syntax-highlighting
git clone https://github.com/BucketSran/dotfiles.git ~/dotfiles
cd ~/dotfiles && stow zsh tmux
```

## 日常用法

- 改配置 = 直接编辑本仓库里的文件（软链接自动生效）
- 每次改动 `lg` 打开 lazygit，`a → c → 注释 → P` 提交推送
