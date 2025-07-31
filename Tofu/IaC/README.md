# Tofu Infrastructure as Code

Este diretório contém a infraestrutura como código usando OpenTofu (fork do Terraform).

## Configuração do Backend

Atualmente, este projeto usa um **backend local** para o estado do Tofu. O arquivo de estado (`terraform.tfstate`) é armazenado localmente e compartilhado entre jobs do GitHub Actions através de artifacts.

### Vantagens do Backend Local

- ✅ Sem problemas de locks
- ✅ Mais simples para desenvolvimento
- ✅ Não requer configuração de permissões especiais
- ✅ Funciona offline

### Desvantagens

- ⚠️ Estado não é persistente entre execuções (depende de artifacts)
- ⚠️ Não há versionamento do estado
- ⚠️ Pode haver inconsistências se múltiplos jobs rodarem simultaneamente

## Desenvolvimento Local

### Pré-requisitos

1. **OpenTofu** instalado (versão 1.6.0 ou superior)
2. **AWS CLI** configurado com credenciais válidas
3. **Git** para versionamento

### Comandos Rápidos

Use o script de desenvolvimento local:

```bash
# Inicializar
./scripts/local-dev.sh init

# Criar plano
./scripts/local-dev.sh plan

# Aplicar mudanças
./scripts/local-dev.sh apply

# Mostrar estado
./scripts/local-dev.sh show

# Destruir infraestrutura
./scripts/local-dev.sh destroy
```

### Comandos Manuais

```bash
# Inicializar
tofu init

# Verificar sintaxe
tofu validate

# Criar plano
tofu plan -out=tfplan

# Aplicar mudanças
tofu apply tfplan

# Mostrar estado
tofu show

# Destruir
tofu destroy
```

## Estrutura dos Arquivos

```
Tofu/IaC/
├── backend.tf              # Configuração do backend local
├── backend-github.tf       # Exemplo de backend GitHub (não usado)
├── main.tf                 # Configuração principal
├── version.tf              # Versões dos providers
├── eks-al2023.tf           # Configuração do EKS
├── scripts/
│   └── local-dev.sh        # Script de desenvolvimento
├── .gitignore              # Arquivos ignorados pelo Git
└── README.md               # Este arquivo
```

## Variáveis de Ambiente

Configure as seguintes variáveis de ambiente para desenvolvimento local:

```bash
export AWS_ACCESS_KEY_ID="sua_access_key"
export AWS_SECRET_ACCESS_KEY="sua_secret_key"
export AWS_REGION="us-east-1"
```

Ou use o AWS CLI:

```bash
aws configure
```

## Troubleshooting

### Estado Travado

Se o estado estiver travado localmente:

```bash
# Forçar unlock (use com cuidado)
tofu force-unlock LOCK_ID

# Ou simplesmente delete o arquivo de estado (se for seguro)
rm terraform.tfstate
```

### Problemas de Permissão

Certifique-se de que suas credenciais AWS têm as permissões necessárias:

- `AmazonEKSClusterPolicy`
- `AmazonEKSWorkerNodePolicy`
- `AmazonEKS_CNI_Policy`
- `AmazonEC2ContainerRegistryReadOnly`

### Limpeza

Para limpar completamente:

```bash
# Remover arquivos temporários
rm -rf .terraform/
rm -f tfplan
rm -f terraform.tfstate*

# Re-inicializar
tofu init
```

## Migração para Backend Remoto

Se você quiser migrar para um backend remoto (S3, GitHub, etc.), edite o arquivo `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "meu-bucket-tfstate"
    key    = "tofu-aws/terraform.tfstate"
    region = "us-east-1"
  }
}
```

E execute:

```bash
tofu init -migrate-state
```

## Contribuindo

1. Faça suas alterações nos arquivos `.tf`
2. Execute `tofu plan` para verificar as mudanças
3. Teste localmente com `tofu apply`
4. Commit e push das mudanças
5. O GitHub Actions irá executar automaticamente 