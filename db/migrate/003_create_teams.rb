class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :name2
    end
  end
end

# {
#   1: 'inter'
#   2: 'milan'
#   3: 'juventus'
# }

# 1

# {
#   1: p1,
#   2: p2,
#   3: p3
# }

# 1

# d

# s

# b

# {
#   1: p1,
#   2: p2,
#   3: p3
# }

# b

# {
#   1: 'inter'
#   2: 'milan'
#   3: 'juventus'
# }

# q