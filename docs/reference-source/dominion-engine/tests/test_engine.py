# pyright: reportPrivateUsage=false

from dominion.cards import CardType
from dominion.cardsets.base import COPPER, ESTATE, PROVINCE, SMITHY, VILLAGE
from dominion.game import Game
from dominion.state import Phase
from dominion.moves import BuyCard, EndBuyPhase, PlayCard, EndActionPhase


def test_legal_moves_in_action_phase():
    game = Game()
    player = game.active_player

    player.hand = []
    player.actions = 1

    moves = game.legal_moves()

    assert EndActionPhase() in moves


def test_legal_moves_include_action_cards():
    game = Game()
    player = game.active_player

    player.actions = 1
    player.hand = [VILLAGE]

    moves = game.legal_moves()

    assert any(isinstance(m, PlayCard) for m in moves)
    assert EndActionPhase() in moves


def test_legal_moves_when_no_actions():
    game = Game()
    player = game.active_player

    player.actions = 0
    player.hand = [VILLAGE]

    moves = game.legal_moves()

    assert all(not isinstance(m, PlayCard) for m in moves)
    assert EndActionPhase() in moves


def test_playing_actions_move_them_to_played():
    game = Game()
    player = game.active_player

    player.hand = [SMITHY]

    game.apply_move(PlayCard(SMITHY))

    assert SMITHY not in player.hand
    assert SMITHY in player.played


def test_buy_moves_respect_cost_and_coins():
    game = Game()
    player = game.active_player

    game.state.phase = Phase.BUY

    player.coins = 4
    player.buys = 1

    moves = game.legal_moves()

    assert EndBuyPhase() in moves
    assert any(isinstance(m, BuyCard) for m in moves)

    # should not include expensive cards
    assert not any(
        isinstance(m, BuyCard) and m.card.cost > 4
        for m in moves
    )


def test_buy_card_reduces_resources_and_supply():
    game = Game()
    player = game.active_player

    game.state.phase = Phase.BUY

    player.coins = 5
    player.buys = 1

    smithy_pile_before = game._supply_pile(SMITHY).count

    game.apply_move(BuyCard(SMITHY))

    assert player.buys == 0
    assert player.coins == 5 - SMITHY.cost
    assert game._supply_pile(SMITHY).count == smithy_pile_before - 1
    assert SMITHY in player.discard


def test_smithy_draws_cards():
    game = Game()
    player = game.active_player

    player.hand = [SMITHY]
    player.deck = [COPPER] * 10

    initial_hand = len(player.hand)

    game.apply_move(PlayCard(SMITHY))

    assert len(player.hand) == initial_hand + 2


def test_village_draws_and_grants_actions():
    game = Game()
    player = game.active_player

    player.hand = [VILLAGE]
    player.deck = [COPPER] * 10

    initial_hand = len(player.hand)

    game.apply_move(PlayCard(VILLAGE))

    assert len(player.hand) == initial_hand
    assert player.actions == 2


def test_cleanup_resets_state_and_advances_player():
    game = Game()

    p1 = game.state.players[0]

    game.state.phase = Phase.BUY

    game.apply_move(EndBuyPhase())

    # player reset
    assert p1.actions == 1
    assert p1.buys == 1
    assert p1.coins == 0
    assert len(p1.hand) == 5

    # turn advanced
    assert game.state.current_player == 1


def test_cleanup_discards_hand():
    game = Game()
    player = game.active_player

    player.hand = [COPPER] * 5

    game.apply_move(EndBuyPhase())

    assert player.discard.count(COPPER) >= 5


def test_game_over_when_provinces_empty():
    game = Game()

    pile = game._supply_pile(PROVINCE)
    pile.count = 0

    assert game.is_game_over()


def test_game_over_when_three_piles_empty():
    game = Game()

    empty_piles = 0
    for pile in game.state.supply:
        if empty_piles < 3:
            pile.count = 0
            empty_piles += 1

    assert game.is_game_over()


def test_end_turn_resets_state():
    game = Game()
    player = game.active_player

    player.actions = 0
    player.buys = 0
    player.coins = 0
    player.hand = []

    game.apply_move(EndBuyPhase())

    assert game.state.phase == Phase.ACTION
    assert game.active_player.actions == 1
    assert game.active_player.buys == 1
    assert game.active_player.coins == 0
    assert len(game.active_player.hand) == 5


def test_only_action_cards_are_playable():
    game = Game()
    player = game.active_player

    player.hand = [COPPER, ESTATE, SMITHY]

    moves = game._legal_action_moves()

    assert all(
        m.card.types and CardType.ACTION in m.card.types
        for m in moves if isinstance(m, PlayCard)
    )


def test_cannot_buy_if_not_enough_coins():
    game = Game()
    player = game.active_player

    player.coins = 0
    player.buys = 1

    moves = game._legal_buy_moves()

    assert all(
        not isinstance(m, BuyCard) or m.card.cost == 0
        for m in moves
    )


def test_buy_reduces_supply():
    game = Game()
    player = game.active_player

    player.coins = 10
    player.buys = 1

    pile = game.state.supply[0]
    initial = pile.count

    game.apply_move(BuyCard(pile.card))

    assert pile.count == initial - 1


def test_empty_supply_piles_cannot_be_bought():
    game = Game()

    game.state.phase = Phase.BUY

    pile = game._supply_pile(SMITHY)
    pile.count = 0

    player = game.active_player
    player.coins = 10
    player.buys = 1

    moves = game.legal_moves()

    assert BuyCard(SMITHY) not in moves
