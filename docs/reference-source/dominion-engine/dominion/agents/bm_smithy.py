from dominion.cards import Card
from dominion.cardsets.base import GOLD, PROVINCE, SILVER, SMITHY
from dominion.moves import BuyCard, EndActionPhase, EndBuyPhase, Move, PlayCard
from dominion.state import GameState, Phase


class BMSmithy:
    def choose(self, state: GameState, moves: list[Move]) -> Move:
        phase = state.phase

        if phase == Phase.ACTION:
            playable_actions = [
                move
                for move in moves
                if isinstance(move, PlayCard)
            ]

            for move in moves:
                if isinstance(move, PlayCard):
                    if move.card is SMITHY:
                        return move

                if isinstance(move, EndActionPhase) and not playable_actions:
                    return move

        if phase == Phase.BUY:
            buy_moves = [
                move
                for move in moves
                if isinstance(move, BuyCard)
            ]

            all_player_cards = state.active_player().all_cards()
            smithies = sum(1 for card in all_player_cards if card is SMITHY)
            should_buy_smithy = smithies == 0 or len(all_player_cards) / smithies <= 10

            if should_buy_smithy and not self.find_buy_move(buy_moves, PROVINCE):
                move = self.find_buy_move(buy_moves, SMITHY)
                if move:
                    return move


            return (
                self.find_buy_move(buy_moves, PROVINCE)
                or self.find_buy_move(buy_moves, GOLD)
                or self.find_buy_move(buy_moves, SILVER)
                or next((m for m in moves if isinstance(m, EndBuyPhase)), moves[0])
            )

        # Should never get here
        return moves[0]

    def find_buy_move(self, moves: list[BuyCard], card: Card) -> BuyCard | None:
        return next(
            (
                move
                for move in moves
                if move.card is card
            ),
            None,
        )
