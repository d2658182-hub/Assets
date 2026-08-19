# 🎮 Game Assets — Multi-Platform Ready

Assets redimensionnés et organisés par éditeur de jeux web.

## Structure

```
Assets/
├── originals/              ← Images sources (7 PNG originaux)
├── playgama/               ← Assets pour Playgama
│   ├── icons/              ← 512×512 px (carré)
│   ├── thumbnails/         ← 800×450 px (16:9)
│   └── screenshots/        ← 1280×720 px (16:9)
├── crazygames/             ← Assets pour CrazyGames
│   ├── icons/              ← 512×512 px (carré)
│   ├── thumbnails/         ← 800×450 px (16:9)
│   └── screenshots/        ← 1280×720 px (16:9)
├── yandex-games/           ← Assets pour Yandex Games
│   ├── icons/              ← 200×200 px (carré)
│   ├── thumbnails/         ← 1280×720 px (16:9)
│   └── screenshots/        ← 1280×720 px (16:9)
├── gamedistribution/       ← Assets pour GameDistribution
│   ├── icons/              ← 200×200 px (carré)
│   ├── thumbnails/         ← 800×450 px (16:9)
│   └── screenshots/        ← 1280×720 px (16:9)
├── gamepix/                ← Assets pour GamePix
│   ├── icons/              ← 200×200 px (carré)
│   ├── thumbnails/         ← 800×450 px (16:9)
│   └── screenshots/        ← 1280×720 px (16:9)
└── gamemonetize/           ← Assets pour GameMonetize
    ├── icons/              ← 200×200 px (carré)
    ├── thumbnails/         ← 800×450 px (16:9)
    └── screenshots/        ← 1280×720 px (16:9)
```

## Dimensions par plateforme

| Plateforme        | Icône      | Thumbnail    | Screenshot   | Format |
|-------------------|------------|--------------|--------------|--------|
| **Playgama**      | 512×512    | 800×450      | 1280×720     | PNG    |
| **CrazyGames**    | 512×512    | 800×450      | 1280×720     | PNG    |
| **Yandex Games**  | 200×200    | 1280×720     | 1280×720     | PNG    |
| **GameDistribution** | 200×200 | 800×450      | 1280×720     | PNG    |
| **GamePix**       | 200×200    | 800×450      | 1280×720     | PNG    |
| **GameMonetize**  | 200×200    | 800×450      | 1280×720     | PNG    |

## Comment ça marche

1. Les images sources sont dans `originals/`
2. Le script `resize_assets.sh` utilise ImageMagick pour redimensionner automatiquement :
   - **Icons** : crop carré centré + redimensionnement
   - **Thumbnails** : redimensionnement avec padding centré
   - **Screenshots** : redimensionnement avec padding centré
3. Chaque dossier contient 7 images (une par asset source)

## Script de redimensionnement

```bash
bash resize_assets.sh
```

## Notes

- Toutes les images sont au format PNG haute qualité (qualité 95%)
- Les images portrait sont recadrées au centre pour les icônes carrées
- Les images paysage sont redimensionnées proportionnellement
- Les dossiers peuvent être directement uploadés sur les plateformes respectives
