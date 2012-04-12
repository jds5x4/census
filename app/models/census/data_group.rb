require 'acts_as_list'
module Census
  class DataGroup < ActiveRecord::Base

    acts_as_list
    default_scope :order => :position

    has_many :questions, :dependent => :destroy, :inverse_of => :data_group
    accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:prompt].blank? }, :allow_destroy => true
    
    validates_presence_of :name
    
  end
end