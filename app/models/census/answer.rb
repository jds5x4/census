module Census
  class Answer < ActiveRecord::Base

    belongs_to :question, :inverse_of => :answers, :class_name => 'Census::Question'
    belongs_to :user, :inverse_of => :answers, :class_name => '::User'

    validates_presence_of :question,
                          :user 
                          
    validate :ensure_valid_choice
    validate :ensure_valid_data_type
    validate :check_multiple_answers
    
    scope :for_user, lambda { |user| { :conditions => {:user_id => user.id} } }

    attr_accessible :data, :question_id

    def formatted_data
      question.format_data(self.data)
    end

    def to_s
      question.to_s(self.data)
    end

    def data
      data = read_attribute(:data)
      question.format_data(data) #unless data.blank?
    end

    # def data=(data)
    #   debugger
    #   write_attribute(:data, question.data_to_string(data)) unless data.blank?
    # end
    # def data
    #   if question.data_type == 'Date'
    #     date = read_attribute(:data)
    #     begin
    #       #date_data = Date.strptime(read_attribute(:data), '%m/%d/%Y')
    #       date_data = Date.parse(read_attribute(:data)).strftime("%B %d, %Y")
    #     rescue
    #       nil
    #     end
    #   else
    #     read_attribute(:data)
    #   end
    # end

    # def data=(data)
    #   if question.data_type == 'Date'
    #     write_attribute(:data, "#{data.to_s}")
    #   else
    #     write_attribute(:data, data)
    #   end
    # end
    
    private
    
    
    def ensure_valid_choice
      return if question.blank? || data.blank?
      errors[:base] << "Invalid choice for #{question.prompt}" if question.restrict_values? && !question.choices.map(&:value).include?(self.data)
    end
    
    def ensure_valid_data_type
      return if question.blank? || data.blank?
      message = question.validate_data(data)
      errors[:base] << "#{question.prompt} #{message}" if message
    end
    
    def check_multiple_answers
      return if question.blank? || user.blank?
      errors[:base] << "Only one answer allowed for #{question.prompt}"  if new_record? && question.answers.for_user(user).size > 0 && !question.multiple?
    end
    
  end
end