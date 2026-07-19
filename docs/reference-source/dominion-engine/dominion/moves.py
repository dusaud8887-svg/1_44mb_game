from dataclasses import dataclass

from dominion.cards import Card

@dataclass(frozen=True)
class Move:
    pass


@dataclass(frozen=True)
class PlayCard(Move):
    card: Card


@dataclass(frozen=True)
class BuyCard(Move):
    card: Card


@dataclass(frozen=True)
class EndActionPhase(Move):
    pass


@dataclass(frozen=True)
class EndBuyPhase(Move):
    pass
