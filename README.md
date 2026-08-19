# 🎮 Game Assets — Multi-Platform Ready

Assets redimensionnés et organisés par éditeur de jeux web.

## Logique de redimensionnement

**Chaque image est redimensionnée selon son orientation d'origine :**

| Orientation source | Exemple | → Format cible |
|-------------------|---------|----------------|
| **LANDSCAPE** (plus large que haute) | 1448×1086 | Format paysage du portail |
| **PORTRAIT** (plus haute que large) | 942×1670 | Format portrait du portail |
| **SQUARE** (carrée) | 1254×1254 | Format carré du portail |

## 7 Images sources

| Image | Dimensions | Orientation |
|-------|------------|-------------|
| `...14c822f...` | 942×1670 | PORTRAIT |
| `...286881f...` | 1448×1086 | LANDSCAPE |
| `...633c824...` | 941×1672 | PORTRAIT |
| `...637481f...` | 1448×1086 | LANDSCAPE |
| `...b73081f...` | 1448×1086 | LANDSCAPE |
| `...e02881f...` | 1254×1254 | SQUARE |
| `...e8ec824...` | 923×1704 | PORTRAIT |

**Total : 3 LANDSCAPE + 4 PORTRAIT + 1 SQUARE**

## Dimensions par plateforme

| Plateforme | LANDSCAPE | PORTRAIT | SQUARE |
|------------|-----------|----------|--------|
| **Playgama** | 1920×1080 | 1080×1920 | 800×800 |
| **CrazyGames** | 1280×720 | 720×1280 | 512×512 |
| **Yandex Games** | 1280×720 | 720×1280 | 200×200 |
| **GameDistribution** | 800×450 | 450×800 | 200×200 |
| **GamePix** | 800×450 | 450×800 | 200×200 |
| **GameMonetize** | 800×450 | 450×800 | 200×200 |

## Structure

```
Assets/
├── originals/                  ← 7 images sources
├── playgama/                   ← 7 fichiers (3 paysage + 3 portrait + 1 carré)
├── crazygames/                 ← 7 fichiers
├── yandex-games/               ← 7 fichiers
├── gamedistribution/           ← 7 fichiers
├── gamepix/                    ← 7 fichiers
├── gamemonetize/               ← 7 fichiers
├── resize_all_correct.sh       ← Script principal (recommandé)
├── resize_playgama_correct.sh  ← Script Playgama seul
└── README.md
```

## Vérification rapide

```bash
# Vérifier les dimensions
for f in playgama/*.png; do
  echo "$(basename $f): $(identify -format '%wx%h' $f)"
done
```

## Notes

- Toutes les images sont au format PNG haute qualité (qualité 95%)
- Les images sont redimensionnées proportionnellement avec padding centré
- **Playgama** : dimensions vérifiées depuis leur documentation développeur
- **Autres plateformes** : dimensions standards du marché HTML5
