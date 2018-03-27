class Museum
  attr_reader :name,
              :exhibits,
              :revenue,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = {}
    @revenue = 0
    @patrons = {}
  end

  def add_exhibit(name, cost)
    @exhibits[name] = cost
  end

  def admit(patron)
    @revenue += 10
    patron.interests.each do |interest|
      price = @exhibits[interest]
      if price != nil
        @revenue += price
        add_patron(interest, patron)
      end
    end
  end

  def add_patron(exhibit, patron)
    if @patrons[exhibit] != nil
      @patrons[exhibit] << patron
    else
      @patrons[exhibit] = [patron]
    end
  end

  def patrons_of(exhibit)
    return [] unless @patrons[exhibit]
    @patrons[exhibit].map do |patron|
      patron.name
    end
  end

  def exhibits_by_attendees
    sorted = @exhibits.sort_by do |name, cost|
      -patrons_of(name).length
    end

    sorted.map do |name, cost|
      name
    end
  end

  def remove_unpopular_exhibits(threshold)
    @exhibits.delete_if do |name, cost|
      patrons_of(name).length <= threshold
    end
  end
end
