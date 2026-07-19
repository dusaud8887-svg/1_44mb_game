import random

from dominion.cards import Card, CardType
from dominion.cardsets.base import COPPER, ESTATE, PROVINCE, SMITHY, VILLAGE
from dominion.moves import BuyCard, EndActionPhase, EndBuyPhase, Move, PlayCard
from dominion.player import Player
from dominion.state import GameState, Phase
from dominion.supply import SupplyPile

class Game:
    state: GameState

    def __init__(self):
        players = [
            Player(name="Player 1", deck=Game.create_starting_deck()),
            Player(name="Player 2", deck=Game.create_starting_deck()),
        ]
        for player in players:
            player.draw(5)
        self.state = GameState(players=players)

    @staticmethod
    def create_starting_deck() -> list[Card]:
        deck: list[Card] = [COPPER] * 7 + [ESTATE] * 3
        random.shuffle(deck)
        return deck

    @property
    def active_player(self) -> Player:
        return self.state.players[self.state.current_player]

    def legal_moves(self) -> list[Move]:
        match self.state.phase:
            case Phase.ACTION:
                return self._legal_action_moves()

            case Phase.TREASURE:
                raise RuntimeError("TREASURE phase should never request legal moves.")

            case Phase.BUY:
                return self._legal_buy_moves()

            case Phase.CLEANUP:
                return []

    def _legal_action_moves(self) -> list[Move]:
        player = self.active_player
        moves: list[Move] = [EndActionPhase()]

        if player.actions > 0:
            moves.extend(
                PlayCard(card)
                for card in player.hand
                if CardType.ACTION in card.types
            )
        return moves

    def _legal_buy_moves(self) -> list[Move]:
        player = self.active_player
        moves: list[Move] = [EndBuyPhase()]

        if player.buys > 0:
            moves.extend(
                BuyCard(pile.card)
                for pile in self.state.supply
                if pile.count > 0 and pile.card.cost <= player.coins
            )
        return moves

    def apply_move(self, move: Move) -> None:
        if isinstance(move, PlayCard):
            card = move.card
            player = self.active_player
            print(f"{player.name} plays {card.name}")

            player.actions -= 1

            player.play(card)
            if card is VILLAGE:
                player.draw(1)
                player.actions += 2

            elif card is SMITHY:
                player.draw(3)

        elif isinstance(move, BuyCard):
            player = self.active_player
            card = move.card

            print(f"{player.name} buys {card.name}")

            player.coins -= card.cost
            player.buys -= 1
            pile = self._supply_pile(card)
            pile.count -= 1
            player.discard.append(card)

        elif isinstance(move, EndActionPhase):
            self.state.phase = Phase.TREASURE
            self._play_all_treasures()
            self.state.phase = Phase.BUY

        elif isinstance(move, EndBuyPhase):
            self.state.phase = Phase.CLEANUP
            self._end_turn()

    def _play_all_treasures(self) -> None:
        player = self.active_player

        # Assume we automatically play every Treasure Card
        player.coins = sum(
            card.treasure
            for card in player.hand
            if CardType.TREASURE in card.types
        )
        print(f"{player.name} plays treasures for {player.coins} coins")

    def _supply_pile(self, card: Card) -> SupplyPile:
        return next(
            pile
            for pile in self.state.supply
            if pile.card == card
        )

    def _cleanup(self) -> None:
        player = self.active_player

        print(
            f"{player.name}: " +
            f"Deck={len(player.deck)} " +
            f"Discard={len(player.discard)} " +
            f"Played={len(player.played)}"
        )

        player.discard_hand()
        player.discard_played()
        player.actions = 1
        player.buys = 1
        player.coins = 0
        player.draw(5)

    def _next_player(self) -> None:
        self.state.current_player = (self.state.current_player + 1) % len(self.state.players)
        if self.state.current_player == 0:
            self.state.turn += 1

    def _end_turn(self) -> None:
        self._cleanup()
        self._next_player()
        self.state.phase = Phase.ACTION

    def is_game_over(self) -> bool:
        # TODO 4 empty piles for 5-6 players
        empty_piles = sum(
            1
            for pile in self.state.supply
            if pile.is_empty()
        )

        return self._supply_pile(PROVINCE).is_empty() or empty_piles >= 3
