require_relative '../range_list'
require "test/unit"

class RangeListTest < Test::Unit::TestCase
  def test_range_list_new
    assert(RangeList.new.range_lists_show.empty?)
    assert(RangeList.new.range_count.zero?)
  end

  test "add [1,5]" do 
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)
  end

  test "add [1,5], [10,20]" do
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)

    rl.add([10, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)
  end

  test "add [1,5], [10,20], [20, 20]" do
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)

    rl.add([10, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([20, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)
  end

  test "add [1,5], [10,20] [2,4]" do
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)

    rl.add([10, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([2, 4])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)
  end

  test "add [1,5], [10,20] [2,4] [1,7]" do
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)

    rl.add([10, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([2, 4])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([1, 7])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 7 ) [ 10, 20 ) ", rl.print)
  end

  test "add [1,5], [10,20] [2,4] [1,7] [25,30]" do
    rl = RangeList.new
    assert_equal(0, rl.range_count)

    rl.add([1, 5])
    assert_equal(1, rl.range_count)
    assert_equal("[ 1, 5 ) ", rl.print)

    rl.add([10, 20])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([2, 4])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 5 ) [ 10, 20 ) ", rl.print)

    rl.add([1, 7])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 7 ) [ 10, 20 ) ", rl.print)

    rl.add([25, 30])
    assert_equal(3, rl.range_count)
    assert_equal("[ 1, 7 ) [ 10, 20 ) [ 25, 30 ) ", rl.print)
  end

  test " add [1,8], [10,21], remove [10,11]" do
    rl = RangeList.new
    rl.add([1, 8])
    rl.add([10, 21])
    assert_equal(2, rl.range_count)

    rl.remove([10, 11])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 8 ) [ 11, 21 ) ", rl.print)
  end

  test " add [1,8], [10,21], remove [10,11], [15,17]" do
    rl = RangeList.new
    rl.add([1, 8])
    rl.add([10, 21])
    assert_equal(2, rl.range_count)

    rl.remove([10, 11])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 8 ) [ 11, 21 ) ", rl.print)

    rl.remove([15, 17])
    assert_equal(3, rl.range_count)
    assert_equal("[ 1, 8 ) [ 11, 15 ) [ 17, 21 ) ", rl.print)
  end

  test " add [1,8], [10,21], remove [10,11], [15,17] [3, 19]" do
    rl = RangeList.new
    rl.add([1, 8])
    rl.add([10, 21])
    assert_equal(2, rl.range_count)

    rl.remove([10, 11])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 8 ) [ 11, 21 ) ", rl.print)


    rl.remove([15, 17])
    assert_equal(3, rl.range_count)
    assert_equal("[ 1, 8 ) [ 11, 15 ) [ 17, 21 ) ", rl.print)

    rl.remove([3, 19])
    assert_equal(2, rl.range_count)
    assert_equal("[ 1, 3 ) [ 19, 21 ) ", rl.print)
  end
end