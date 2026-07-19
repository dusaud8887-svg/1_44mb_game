from dominion.agents.bm_smithy import BMSmithy
from dominion.cardsets.base import COPPER, GOLD, PROVINCE, SILVER, SMITHY
from dominion.game import Game
from dominion.moves import BuyCard, EndActionPhase, EndBuyPhase
from dominion.state import Phase


def test_bm_smithy_always_ends_action_phase():
    game = Game()

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, EndActionPhase)


def test_bm_smithy_buys_province_if_possible():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    # Player has 10 cards total with no Smithies, so they should otherwise buy Smithy
    player.coins = 8
    player.buys = 1

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is PROVINCE


def test_bm_smithy_buys_smithy_first_when_affordable():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 4

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is SMITHY


def test_bm_smithy_buys_smithy_every_ten_cards():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 4
    player.deck = [SMITHY] + [COPPER] * 4 # player has 5 cards in hand for 10 total

    print(player.all_cards())
    print(len(player.all_cards()))
    print(sum(1 for card in player.all_cards() if card is SMITHY))

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is SMITHY


def test_bm_smithy_stops_buying_smithy_over_threshold():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 6
    player.deck = [SMITHY] + [COPPER] * 5 # player has 5 cards in hand for 11 total

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is GOLD


def test_bm_smithy_buys_money_over_other_actions():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 4
    player.buys = 1
    player.deck = [SMITHY] + [COPPER] * 5

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, BuyCard)
    assert move.card is SILVER


def test_bm_smithy_does_not_buy_copper():
    game = Game()
    player = game.active_player
    game.state.phase = Phase.BUY

    player.coins = 2
    player.buys = 1

    agent = BMSmithy()
    move = agent.choose(game.state, game.legal_moves())

    assert isinstance(move, EndBuyPhase)
