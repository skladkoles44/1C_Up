#!/bin/bash

# Настройка
GH_REPO="https://github.com/skladkoles44/1C_Up.git"
GH_USER="skladkoles44"
BRANCH="main"

# Очистка старого
rm -rf .git
git init
git config user.name "$GH_USER"
git config user.email "$GH_USER@users.noreply.github.com"
git remote add origin "$GH_REPO"

# Структура
mkdir -p .github/workflows
mkdir -p scripts

echo "# Автообновление релизов 1С" > README.md

cat > releases.md << 'EOR'
# Релизы 1С (автообновление)
Документ обновляется автоматически через GitHub Actions.
EOR

cat > platform.json << 'EOP'
{
  "releases": []
}
EOP

cat > .github/workflows/1c_releases_sync.yml << 'EOY'
name: 1C Release Sync

on:
  schedule:
    - cron: "0 5 * * *"
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run parser
        run: echo "🔧 Парсер будет добавлен позже"
EOY

cat > scripts/parse_1c_updates.sh << 'EOS'
#!/bin/bash
echo "🔧 Здесь будет парсер релизов 1С (releases.1c.ru, its.1c.ru)"
EOS

chmod +x scripts/parse_1c_updates.sh

# Коммит и пуш
git add .
git commit -m "Инициализация автообновления релизов 1С"
git branch -M $BRANCH
git push -u origin $BRANCH
