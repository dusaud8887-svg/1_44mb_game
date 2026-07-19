from dataclasses import dataclass

from dominion.cards import Card


@dataclass
class SupplyPile:
    card: Card
    count: int = 10

    def is_empty(self) -> bool:
        return self.count <= 0
