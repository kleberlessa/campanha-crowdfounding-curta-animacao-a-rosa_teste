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
