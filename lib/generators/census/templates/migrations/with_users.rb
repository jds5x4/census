class CreateCensusTables < ActiveRecord::Migration
  def self.up
    create_table :census_data_groups do |t|
      t.string  :name
      t.integer :position
      t.timestamps
    end

    create_table :census_questions do |t|
      t.integer :data_group_id
      t.string  :data_type
      t.string  :prompt
      t.boolean :multiple
      t.boolean :other
      t.integer :position
      t.timestamps
    end
    
    add_index :census_questions, :data_group_id, :name => "idx_qstns_datagrpid"
    
    create_table :census_choices do |t|
      t.integer :question_id
      t.string  :value
      t.integer :position
      t.string  :group
      t.timestamps
    end
    
    add_index :census_choices, :question_id, :name => "idx_choices_qstnid"
    
    create_table(:users) do |t|
      t.timestamps
    end

    create_table :census_answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.string  :data
    end
    
    add_index :census_answers, :question_id, :name => "idx_answrs_qstnid"
    add_index :census_answers, :user_id, :name => "idx_answrs_usrid"
    
  end

  def self.down
    remove_index :census_answers, :name => "idx_answrs_qstnid"
    remove_index :census_answers, :name => "idx_answrs_usrid"
    drop_table :census_answers
    
    drop_table :census_users
    
    remove_index :census_choices, :name => "idx_choices_qstnid"
    drop_table :census_choices
    
    remove_index :census_questions, :name => "idx_qstns_datagrpid"
    drop_table :census_questions
    
    drop_table :census_data_groups
  end
end
