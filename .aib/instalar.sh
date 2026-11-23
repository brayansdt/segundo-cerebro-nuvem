#!/bin/sh
# Instala o aib que vem neste repositório (pasta .aib), sem baixar nada.
# Roda pelo hook de início de sessão do .claude/settings.json, só nas sessões na nuvem.
# Hooks não passam pelo classificador do modo automático: o Claude nunca precisa instalar o aib.
# Este arquivo é gerenciado: a Action "Atualizar do Segundo Cérebro" traz a versão nova toda semana.
set -eu

pasta="$(cd "$(dirname "$0")" && pwd)"
log="$HOME/.aib-instalacao.log"
printf '%s\n' "repositorio" > "$HOME/.aib-instalacao-origem"

falhar() {
  echo "Cérebro na Nuvem: $1" >&2
  echo "fim 1 $1" >> "$log"
  exit 0
}

case "$(uname -s)" in Linux) os=linux ;; *) falhar "sistema não suportado: $(uname -s)" ;; esac
case "$(uname -m)" in
  x86_64|amd64) arq=amd64 ;;
  arm64|aarch64) arq=arm64 ;;
  *) falhar "processador não suportado: $(uname -m)" ;;
esac

arquivo="aib-$os-$arq.gz"
[ -f "$pasta/$arquivo" ] || falhar "o repositório não traz o $arquivo"
[ -f "$pasta/checksums" ] || falhar "o repositório não traz o arquivo checksums"

esperado="$(awk -v a="$arquivo" '$2 == a { print $1 }' "$pasta/checksums")"
obtido="$(sha256sum "$pasta/$arquivo" | cut -d' ' -f1)"
[ -n "$esperado" ] && [ "$esperado" = "$obtido" ] || falhar "o $arquivo não confere com o checksums; nada foi instalado"

destino="$HOME/.aib/bin"
mkdir -p "$destino"
gunzip -c "$pasta/$arquivo" > "$destino/aib.novo"
chmod 0755 "$destino/aib.novo"
mv -f "$destino/aib.novo" "$destino/aib"

for p in /usr/local/bin "$HOME/.local/bin"; do
  if mkdir -p "$p" 2>/dev/null && [ -w "$p" ] && ln -sfn "$destino/aib" "$p/aib" 2>/dev/null; then break; fi
done

versao="$("$destino/aib" --version 2>/dev/null | awk '{print $NF}')"
echo "aib $versao do repositório em $destino/aib" > "$log"
echo "fim 0" >> "$log"

# Se o cérebro já estiver conectado nesta sessão, traz as notas mais novas.
if [ -f "$HOME/cerebro/CLAUDE.md" ]; then "$destino/aib" pull --rapido || true; fi
