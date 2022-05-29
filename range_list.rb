class RangeList
  attr_reader :implements, :range_lists_show

  def initialize(implement = [])
    @implements = implement
    @range_lists_show = ""
  end

  def indexs(index)
    implements[index]
  end

  def range_count
    implements.size
  end

  def add(range)
    validate(range)

    update_ranges = range
    implements_ranges = []
    remain_ranges = []
    implements << update_ranges if implements.empty?

    implements.each_with_index do |implement, index|
      compara_code = compara(range, implement)
      case compara_code
      when -2
        implements_ranges << implement
        next
      when 0
        update_ranges = create_range_with_index(range, index)
        next
      when 2
        remain_ranges = implements.delete_at(index)
        break
      end
    end

    implements_ranges << update_ranges
    implements_ranges << remain_ranges
    implements_ranges.delete_if { |item| item.empty? }

    @implements = implements_ranges
    @range_lists_show = ""
  end

  def remove(range)
    validate(range)
    
    return if range_count.zero?

    update_ranges = range
    implements_ranges = []
    remain_ranges = []

    @implements.each_with_index do |implement, index|
      compara_code = compara(range, implement)
      case compara_code
      when -2
        implements_ranges << implement
        next
      when 0
        results = check_and_create_ranges(implement, range)
        results.each { |result| implements_ranges << result }
        next
      when 2
        remain_ranges = implements.delete_at(index)
        break
      end
    end

    implements_ranges << remain_ranges
    implements_ranges.delete_if { |item| item.empty? }

    @implements = implements_ranges
    @range_lists_show = ""
  end

  def print
    p range_lists
  end

  private

  attr_writer :implements, :range_lists_show

  def validate(params)
    raise "Range error: need first value > last value, like [2, 4], [7,10]" if params.last - params.first < 0
    raise "Type error: This method need array params" unless params.is_a?(Array)
    raise "Size error: params count only <= 2" if params.size <= 1 || params.size >= 3
  end

  def check_and_create_ranges(implement, range)
    result = []
    if range.first.to_i > implement.first.to_i
      result << [implement.first, range.first]
    end

    if implement.last.to_i > range.last.to_i
      result << [range.last, implement.last]
    end
    result
  end


  def create_range_with_index(range, index)
    new_ranges_first = [implements[index].first, range.first].min
    new_ranges_last = [implements[index].last, range.last].max
    [new_ranges_first, new_ranges_last]
  end

  def compara(range, implement)
    return 2 if (range.last < implement.first)
    return -2 if (range.first > implement.last)
    0
  end

  def range_lists
    @implements.each do |implement|
      range_lists_show << "[ #{implement.first}, #{implement.last} ) "
    end

    range_lists_show
  end
end
