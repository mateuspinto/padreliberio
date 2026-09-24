# Mina do Padre Libério

App (Android/iOS) e site (Web) da Mina do Padre Libério — São José da Varginha, MG. Câmera ao vivo, horários de missa, doação via PIX, história e informações de visitação.

Site desenvolvido e doado à Igreja, sem qualquer cobrança.

## Desenvolvimento

Comandos disponíveis no `Makefile`:

```bash
make web                # dev server web (CanvasKit, release)
make android            # build release + instala no celular conectado
make android TEST=1     # idem, mas usando o canal de teste (sempre ao vivo)
make dandroid            # debug com hot reload no celular
make dandroid TEST=1
```

`TEST=1` troca o canal do YouTube usado na detecção de "missa/live ao vivo" (`lib/core/live_priority.dart`) por um canal que está sempre ao vivo, pra testar a tela sem esperar uma transmissão real.

## Deploy

A versão web é publicada automaticamente no GitHub Pages a cada push na `main` (`.github/workflows/deploy.yml`).
