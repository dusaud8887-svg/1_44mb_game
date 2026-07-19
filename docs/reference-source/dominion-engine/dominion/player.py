import random
from dataclasses import dataclass, field

from dominion.cards import Card, CardType


@dataclass
class Player:
    name: str
    deck: list[Card]
    hand: list[Card] = field(default_factory=list)
    played: list[Card] = field(default_factory=list)
    discard: list[Card] = field(default_factory=list)

    actions: int = 1
    buys: int = 1
    coins: int = 0

    def all_cards(self) -> list[Card]:
        return self.deck + self.hand + self.played + self.discard

    def draw(self, n: int) -> None:
        for _ in range(n):
            if not self.deck:
                self._reshuffle()

            self.hand.append(self.deck.pop())

    def play(self, card: Card) -> None:
        self.hand.remove(card)
        self.played.append(card)

    def discard_hand(self) -> None:
        self.discard.extend(self.hand)
        self.hand.clear()

    def discard_played(self) -> None:
        self.discard.extend(self.played)
        self.played.clear()

    def score(self) -> int:
        return sum(
            card.victory_points
            for card in self.all_cards()
        )

    def _reshuffle(self) -> None:
        self.deck = self.discard
        self.discard = []
        random.shuffle(self.deck)
