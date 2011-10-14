ActiveRecord::Schema.define(:version => 1) do

  create_table :people, :force => true do |t|
    t.column :name, :string
    t.column :birthday, :date
  end

  create_table :marriages, :force => true do |t|
    t.column :faithful, :boolean
    t.column :anniversary, :datetime
  end

end