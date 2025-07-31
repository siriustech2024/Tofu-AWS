#!/bin/bash

# Script para desenvolvimento local com Tofu
# Uso: ./scripts/local-dev.sh [init|plan|apply|destroy|show]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IAC_DIR="$(dirname "$SCRIPT_DIR")"

cd "$IAC_DIR"

case "$1" in
    init)
        echo "🔧 Inicializando Tofu..."
        tofu init
        ;;
    plan)
        echo "📋 Executando Tofu Plan..."
        tofu plan -out=tfplan
        ;;
    apply)
        echo "🚀 Aplicando mudanças..."
        if [ -f "tfplan" ]; then
            tofu apply tfplan
        else
            echo "❌ Arquivo tfplan não encontrado. Execute 'plan' primeiro."
            exit 1
        fi
        ;;
    destroy)
        echo "🗑️  Destruindo infraestrutura..."
        read -p "Tem certeza que deseja destruir a infraestrutura? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            tofu destroy -auto-approve
        else
            echo "Operação cancelada."
        fi
        ;;
    show)
        echo "📊 Mostrando estado atual..."
        tofu show
        ;;
    *)
        echo "Uso: $0 {init|plan|apply|destroy|show}"
        echo ""
        echo "Comandos:"
        echo "  init    - Inicializa o Tofu"
        echo "  plan    - Cria um plano de execução"
        echo "  apply   - Aplica as mudanças"
        echo "  destroy - Destrói a infraestrutura"
        echo "  show    - Mostra o estado atual"
        exit 1
        ;;
esac 