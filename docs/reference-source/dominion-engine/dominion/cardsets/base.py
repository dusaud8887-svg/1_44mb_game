from dominion.cards import Card, CardType

COPPER = Card(
    name="Copper",
    cost=0,
    types={CardType.TREASURE},
    treasure=1,
)

SILVER = Card(
    name="Silver",
    cost=3,
    types={CardType.TREASURE},
    treasure=2,
)

GOLD = Card(
    name="Gold",
    cost=6,
    types={CardType.TREASURE},
    treasure=3,
)

ESTATE = Card(
    name="Estate",
    cost=2,
    types={CardType.VICTORY},
    victory_points=1,
)

DUCHY = Card(
    name="Duchy",
    cost=5,
    types={CardType.VICTORY},
    victory_points=3,
)

PROVINCE = Card(
    name="Province",
    cost=8,
    types={CardType.VICTORY},
    victory_points=6,
)

SMITHY = Card("Smithy", 4, {CardType.ACTION})
VILLAGE = Card("Village", 3, {CardType.ACTION})
MOAT = Card("Moat", 2, {CardType.ACTION})
