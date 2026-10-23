# Segundo Cérebro na nuvem

Ambiente para abrir o seu Segundo Cérebro (The AI Builders) nas sessões do Claude Code na nuvem, em
[claude.ai/code](https://claude.ai/code), também pelo app do Claude no celular.

Este repositório é público e igual para todos os alunos. **Ele nunca guarda notas nem segredos:** as suas notas ficam
no cofre do Cérebro na Nuvem, cifradas com uma chave que só os seus aparelhos têm, e chegam à sessão pelo `aib` depois
que você libera pelo celular. Não crie uma cópia dele nem ponha notas num repositório do GitHub: um repositório não é
cifrado.

## Quem pode usar

Quem tem o Segundo Cérebro e já ativou o backup na nuvem. Para ativar, use o app do Claude no seu computador (aba Code
ou Cowork, num Mac ou num Linux), com o conector The AI Builders ligado, e peça:
"ativa o backup do meu segundo cérebro na nuvem". Ainda não funciona no Windows.

## Como usar (uma vez)

1. Em claude.ai/code, crie um ambiente chamado "Segundo Cérebro" com este repositório (`brayansdt/segundo-cerebro-nuvem`).
2. Sem script de início e sem variáveis de ambiente: nenhum segredo fica no ambiente.
3. Rede: acesso "Custom", mantendo os domínios padrão e liberando os do servidor do Segundo Cérebro e do armazenamento.
   No computador, peça ao Claude "configura o meu segundo cérebro no Claude na nuvem": ele mostra a lista certa.
4. Deixe o conector The AI Builders ligado nas sessões desse ambiente.
5. Abra uma sessão nesse ambiente e digite `/cerebro`. O Claude mostra um link: abra no celular, confira o código de
   verificação e libere.

## O que tem aqui

- `.claude/skills/cerebro`: a skill `/cerebro`, que abre o cérebro na sessão.
- `.claude/skills/juntar-conflitos`: para quando a mesma nota muda em dois aparelhos.
- `.claude/settings.json`: os hooks que buscam as novidades no início da sessão e enviam as suas notas no fim de cada
  resposta (só quando o `aib` já está instalado), e os comandos que o Claude pode rodar sem pedir licença: `aib pull`,
  `push`, `sync`, `onde`, `conectar`, `conflitos` e `restaurar`.

Decidir mudanças nos arquivos de controle (`CLAUDE.md`, `AGENTS.md`, `SKILL.md`...) fica com você, num terminal do seu
computador (`aib propostas`).

## Manutenção

O conteúdo vem da pasta `segundo-cerebro/` do repositório do `aib`; mudanças entram lá primeiro.
