require 'helper'

class TestBenchmark < MiniTest::Test

  def setup
    @bench = Benchmark.new
    @color = Benchmark.new(winner: :blue, loser: :yellow)
  end

  def test_if_no_winner_color_is_present_the_default_is_green
    assert_equal :green, @bench.winner
  end

  def test_if_no_loser_color_is_present_the_default_is_red
    assert_equal :red, @bench.loser
  end

  def test_if_no_option_is_set_the_default_is_light_blue
    assert_equal :light_blue, @bench.option
  end

  def test_a_user_sets_a_color_that_color_is_present
    assert_equal :blue, @color.winner
  end

  def test_the_colors_can_be_set_after_object_is_written
    @color.winner = :yellow
    assert_equal :yellow, @color.winner
  end

  def test_if_a_label_is_the_same_it_wont_repeat_the_test
    @bench.measure {}
    @bench.measure {}
    assert_equal 1, @bench.block_hash.count
  end

  def test_if_the_labels_are_different_block_will_be_added_to_block_hash
    @bench.measure("something") {}
    @bench.measure {}
    assert_equal 2, @bench.block_hash.count
  end

  def test_the_colors_can_be_changed_half_way_thru_the_benchmark_process
    n = 5000
    x = 1000
    @bench.measure("something") {n.times do; a = 1; end;}
    @bench.measure("else") {x.times do; a = 1; end;}
    @bench.winner = :cyan
    @bench.loser = :light_black
    @bench.measure("new_something") {n.times do; a = 1 + 4; end;}
    @bench.measure("new_else") {x.times do; a = 1 + 4; end;}
    @bench.compare
  end

  def test_if_block_is_given_return_true
    assert_equal true, @bench.measure {}
  end

  def test_if_no_block_is_given_user_gets_instructions
    assert_equal false,  @bench.measure
  end

end
