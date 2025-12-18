#!/bin/bash

# ============================================
# SCRIPT: configurar-prettier-rosa.sh
# VERSÃO: 2.0 (Auditada)
# OBJETIVO: Configurar ambiente de desenvolvimento
#           sem afetar arquivos do Hugging Face
# ============================================

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Iniciando configuração do projeto 'A ROSA'...${NC}"
echo "=============================================="

# 0. VERIFICAÇÃO DE PRÉ-REQUISITOS
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ Erro: NPM não está instalado. Instale o Node.js primeiro.${NC}"
    exit 1
fi

# --------------------------------------------------
# 1. BACKUP do package.json atual
# --------------------------------------------------
if [ -f "package.json" ]; then
    cp package.json "package.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${GREEN}✅ Backup do package.json criado${NC}"
else
    echo "⚠️  package.json não encontrado (será criado um novo)"
fi

# --------------------------------------------------
# 2. CORRIGIR o package.json
# --------------------------------------------------
# Nota: Adicionamos live-server às dependências para performance
cat > package.json << 'EOF'
{
  "name": "campanha-crowdfounding-curta-animacao-a-rosa_teste",
  "version": "1.0.0",
  "description": "Site da campanha de crowdfunding 'A ROSA' - Ambiente de desenvolvimento",
  "main": "index.html",
  "scripts": {
    "format": "prettier --write . --ignore-path .prettierignore",
    "format:check": "prettier --check . --ignore-path .prettierignore",
    "serve": "live-server . --port=5501 --entry-file=index.html",
    "prepare": "npm run format:check",
    "clean": "rm -rf node_modules package-lock.json"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/kleberlessa/campanha-crowdfounding-curta-animacao-a-rosa_teste.git"
  },
  "keywords": [
    "animacao",
    "crowdfunding",
    "curta-metragem",
    "acessibilidade"
  ],
  "author": "Kleber Lessa",
  "license": "CC-BY-4.0",
  "bugs": {
    "url": "https://github.com/kleberlessa/campanha-crowdfounding-curta-animacao-a-rosa_teste/issues"
  },
  "homepage": "https://github.com/kleberlessa/campanha-crowdfounding-curta-animacao-a-rosa_teste#readme",
  "devDependencies": {
    "prettier": "^3.0.0",
    "live-server": "^1.2.0"
  },
  "engines": {
    "node": ">=18.0.0"
  }
}
EOF
echo -e "${GREEN}✅ package.json corrigido e otimizado!${NC}"

# --------------------------------------------------
# 3. INSTALAR Dependências (Prettier + Live Server)
# --------------------------------------------------
echo "📦 Instalando dependências..."
npm install

# --------------------------------------------------
# 4. CRIAR .prettierignore (CRÍTICO PARA HF)
# --------------------------------------------------
cat > .prettierignore << 'EOF'
# ============================================
# ARQUIVOS CRÍTICOS DO HUGGING FACE - NÃO FORMATAR!
# ============================================
README.md               # Contém YAML funcional do HF - NÃO MODIFICAR
.gitattributes          # Configuração do Git LFS - NÃO MODIFICAR

# ============================================
# DIRETÓRIOS DO SISTEMA
# ============================================
node_modules/
.git/
.vscode/
.huggingface/
package-lock.json

# ============================================
# ASSETS DA CAMPANHA (preservar binários e textos manuais)
# ============================================
audio/**/*
doc/**/*
**/*.vtt                # Legendas devem manter formato estrito
**/*.txt                # Transcrições manuais

# ============================================
# MÍDIA
# ============================================
*.png
*.jpg
*.jpeg
*.gif
*.mp3
*.mp4
*.ico

# ============================================
# BACKUPS
# ============================================
*.backup.*
EOF
echo -e "${GREEN}✅ .prettierignore criado (protege README.md e Assets)${NC}"

# --------------------------------------------------
# 5. CRIAR .prettierrc.js
# --------------------------------------------------
cat > .prettierrc.js << 'EOF'
module.exports = {
  printWidth: 100,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  singleQuote: true,
  trailingComma: 'es5',
  endOfLine: 'lf',
  overrides: [
    {
      files: '*.html',
      options: {
        printWidth: 120,
        singleQuote: false,
      }
    }
  ]
};
EOF
echo -e "${GREEN}✅ .prettierrc.js criado${NC}"

# --------------------------------------------------
# 6. CONFIGURAR VS CODE
# --------------------------------------------------
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
  "liveServer.settings.port": 5501,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "prettier.requireConfig": true,
  "prettier.ignorePath": ".prettierignore",
  "[markdown]": { "editor.formatOnSave": false },
  "[yaml]": { "editor.formatOnSave": false },
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true
  }
}
EOF
echo -e "${GREEN}✅ VS Code configurado para respeitar o .prettierignore${NC}"

# --------------------------------------------------
# 7. SCRIPT DE VERIFICAÇÃO
# --------------------------------------------------
mkdir -p scripts
cat > scripts/verificar-config.sh << 'EOF'
#!/bin/bash
echo "🔍 VERIFICAÇÃO FINAL..."
if grep -q "README.md" .prettierignore; then
    echo "✅ README.md está protegido contra formatação acidental."
else
    echo "❌ PERIGO: README.md não está protegido!"
fi
if grep -q "live-server" package.json; then
    echo "✅ Live Server configurado."
else
    echo "⚠️ Live Server não encontrado no package.json."
fi
EOF
chmod +x scripts/verificar-config.sh

# --------------------------------------------------
# 8. FINALIZAÇÃO
# --------------------------------------------------
echo ""
echo -e "${GREEN}🎉 CONFIGURAÇÃO CONCLUÍDA!${NC}"
echo "----------------------------------------------"
echo "👉 Para iniciar o site:   npm run serve"
echo "👉 Para formatar código:  npm run format"
echo "----------------------------------------------"